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

$featureName = "Microsoft-Windows-Subsystem-Linux"

if ((Get-WindowsOptionalFeature -Online -FeatureName $featureName).State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -FeatureName $featureName -All -NoRestart
    Write-Host "[0371_enable-feature_Microsoft-Windows-Subsystem-Linux] The Microsoft Windows Subsystem for Linux feature has been activated."
}
else {
    Write-Host "[0371_enable-feature_Microsoft-Windows-Subsystem-Linux] The Microsoft Windows Subsystem for Linux feature is already activated."
}

#wsl --install -d kali-linux