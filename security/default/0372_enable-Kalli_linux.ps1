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

wsl --set-default-version 2

wsl --list --verbose

#wsl.exe --install
#wsl --install -d kali-linux