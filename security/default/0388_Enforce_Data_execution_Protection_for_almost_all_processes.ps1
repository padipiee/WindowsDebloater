<#
.SYNOPSIS
Set  Data Execution Prevention (DEP) to ::  3: DEP is enabled for all processes, but some exceptions are allowed.
0: DEP is disabled for all processes.
1: DEP is enabled for all processes.
2: DEP is enabled for only Windows system components and services. (Default)
3: DEP is enabled for all processes, but some exceptions are allowed.

.DESCRIPTION
https://www.stigviewer.com/stig/microsoft_windows_11/2023-09-29/finding/V-253283

.PARAMETER None

.EXAMPLE

#>

# Define the registry path and property name
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
$propertyName = "ExecuteOptions"

# Get all properties from the registry key
$properties = Get-ItemProperty -Path $registryPath

# Check if the property exists
if ($properties.PSObject.Properties.Name -contains $propertyName) {
    # If the property exists, get its value
    $propertyValue = Get-ItemProperty -Path $registryPath -Name $propertyName
    Write-Output "[0388_Enforce_Data_execution_Protection_for_almost_all_processes] $propertyName = $propertyValue"
} else {
    # If the property does not exist, create it with the default value
    New-ItemProperty -Path $registryPath -Name $propertyName -Value 2 -PropertyType DWord
    Write-Output "[0388_Enforce_Data_execution_Protection_for_almost_all_processes] Created property $propertyName with the default value at the path $registryPath."
}

# Get the current DEP configuration
$dep = (Get-ItemProperty -Path $registryPath -Name $propertyName).$propertyName

# Compare the DEP configuration with the desired value (OptOut = 3)
if ($dep -ne 3) {
    # Suspend BitLocker if enabled
    $bl = Get-BitLockerVolume
    if ($bl.ProtectionStatus -eq "On") {
        Suspend-BitLocker -MountPoint $bl.MountPoint -RebootCount 0
    }

    # Set the DEP configuration to OptOut
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value 3 -Type DWord
    Write-Output "[0388_Enforce_Data_execution_Protection_for_almost_all_processes]  $propertyName with the  value 3 !!! NEED A RESTART !!!!!!!!!!!!!!!!!!!."
 
}
else {
    # DEP is already configured to OptOut
    Write-Output "[0388_Enforce_Data_execution_Protection_for_almost_all_processes]  DEP is already configured to 3: DEP is enabled for all processes, but some exceptions are allowed"
}