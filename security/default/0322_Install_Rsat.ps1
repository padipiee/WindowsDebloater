<#
.SYNOPSIS
Installs the Rsat.GroupPolicy.Management.Tools capability or feature (Remote Server Administration Tools)

.DESCRIPTION
This script checks if the Rsat.GroupPolicy.Management.Tools capability is installed on the local machine. If not, it installs the RSAT feature. It then retrieves and displays the version of the installed capability or feature.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
.\0322_Install_Rsat.ps1
Runs the script to install the Rsat.GroupPolicy.Management.Tools capability or feature.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

$capabilityInstalled_Rsat_GroupPolicy_Management_Tools = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'Rsat.GroupPolicy.Management.Tools*' } | Select-Object -Last 1 State | Select-Object -Last 2 | ForEach-Object { $_.State -replace '.*:\s*','' }

# Install RSAT
#Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online

# If Rsat.ServerCore.Install.Tools capability is not installed, install RSAT feature
if (!$capabilityInstalled_Rsat_GroupPolicy_Management_Tools) {
    Write-Host "Rsat.GroupPolicy.Management.Tools capability not found. Installing RSAT feature..."
    Add-WindowsCapability -Online -Name "Rsat.GroupPolicy.Management.Tools~*"
    $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'Rsat.GroupPolicy.Management.Tools*' } | Select-Object -Last 1 | ForEach-Object { $_.Name }
    
    Write-Host "RSAT feature installed. Version: $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version"
} else {
    $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'Rsat.GroupPolicy.Management.Tools*' } | Select-Object -Last 1 | ForEach-Object { $_.Name }
    Write-Host "Rsat.GroupPolicy.Management.Tools capability is already installed. Version: $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version"
}
