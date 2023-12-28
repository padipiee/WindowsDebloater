# use  0338_List_all_drivers.bat to have a list of all drivers in format (DeviceName;  InfName;  IsSigned;  Manufacturer )

<#
.SYNOPSIS
Lists all drivers installed on the system with detailed information.
From WMI, the script retrieves the driver name, state, status, and started status: 
LinkDate; DisplayName; Started; DriverType; Name; State; Status

.DESCRIPTION
This script retrieves a list of drivers from both driverquery.exe and Get-WmiObject cmdlets. It then finds the common drivers between the two lists and combines their information into a single table. The detailed information includes the display name, module name, state, status, started status, driver type, and link date.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
List all drivers with detailed information:


.OUTPUTS
System.Object
A table containing the combined information of the common drivers.

.NOTES
Author: Your Name
Date: MM/DD/YYYY
Version: 1.0
#>

# Get the list of drivers from driverquery.exe
$driverQueryDrivers = driverquery.exe /FO CSV | ConvertFrom-Csv | Select-Object 'Module Name', 'Display Name', 'Driver Type', 'Link Date'

# Get the list of drivers from Get-WmiObject
$wmiObjectDrivers = Get-WmiObject -Class Win32_SystemDriver | Select-Object Name, State, Status, Started

# Find the common drivers
$commonDrivers = $driverQueryDrivers | Where-Object { ($wmiObjectDrivers.Name -contains $_.'Module Name') }

# Combine the information columns for each common driver
$combinedDrivers = $commonDrivers | ForEach-Object {
    $driverQueryDriver = $_
    $wmiObjectDriver = $wmiObjectDrivers | Where-Object { $_.Name -eq $driverQueryDriver.'Module Name' }

    # Create a custom object that combines the information columns
    New-Object -Type PSObject -Property @{
        'DisplayName' = $driverQueryDriver.'Display Name'
        'Name' = $driverQueryDriver.'Module Name'
        'State' = $wmiObjectDriver.State
        'Status' = $wmiObjectDriver.Status
        'Started' = $wmiObjectDriver.Started
        'DriverType' = $driverQueryDriver.'Driver Type'
        'LinkDate' = $driverQueryDriver.'Link Date'
    }
}

# Output the combined drivers as a table
$combinedDrivers | Format-Table