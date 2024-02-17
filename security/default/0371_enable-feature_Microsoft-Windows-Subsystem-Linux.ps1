<#
.SYNOPSIS
Enables the Microsoft Windows Subsystem for Linux feature.

.DESCRIPTION
This script checks if the Microsoft Windows Subsystem for Linux feature is enabled. If not, it enables the feature using the Enable-WindowsOptionalFeature cmdlet.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Enable-WindowsSubsystemLinux

This example enables the Microsoft Windows Subsystem for Linux feature.

#>

Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -like "*Linux*" }

$featureName = "Microsoft-Windows-Subsystem-Linux"

$featureState = (Get-WindowsOptionalFeature -Online -FeatureName $featureName).State

if ($featureState -eq "Enabled") {
    Write-Host "[0371_enable-feature_Microsoft-Windows-Subsystem-Linux] The Microsoft Windows Subsystem for Linux feature is already activated."
}
else {
    Enable-WindowsOptionalFeature -Online -FeatureName $featureName -All -NoRestart
    Write-Host "[0371_enable-feature_Microsoft-Windows-Subsystem-Linux] The Microsoft Windows Subsystem for Linux feature has been activated."
}

# Check if Virtual Machine Platform is already enabled
$vmPlatform = Get-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform"

if ($vmPlatform.State -ne "Enabled") {
    # Enable Virtual Machine Platform
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    Write-Host "[0371_enable-feature_Microsoft-Windows-Subsystem-Linux] The VirtualMachinePlatform was enabled."
}
else {
    Write-Host "[0371_enable-feature_Microsoft-Windows-Subsystem-Linux] The VirtualMachinePlatform is already enabled."
}

wsl --set-default-version 2
#wsl.exe --install
#wsl --install -d kali-linux