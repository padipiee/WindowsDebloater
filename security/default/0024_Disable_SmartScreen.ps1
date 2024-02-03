
<#
.SYNOPSIS
Disables SmartScreen feature in Windows 10.

.DESCRIPTION
This script disables the SmartScreen feature in Windows 10 by modifying the registry values.
It checks if the registry values for SmartScreenEnabled exist and if their current value is different from the target value.
If the values need to be changed, it updates the registry values accordingly.

.PARAMETER None

.EXAMPLE
.\0024_Disable_SmartScreen.ps1
This example runs the script to disable the SmartScreen feature in Windows 10.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

$targetValue = "Off"

# Check if the registry value exists and its current value
$currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -ErrorAction SilentlyContinue
if ($currentValue -and $currentValue.SmartScreenEnabled -ne $targetValue) {
  Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Value $targetValue -Type String -Force
  Write-Host "[0024_Disable_SmartScreen] - SmartScreen value for SmartScreenEnabled changed to $targetValue"
} else {
  Write-Host "[0024_Disable_SmartScreen] - SmartScreen value is already on target"
}

$currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -ErrorAction SilentlyContinue
if ($currentValue -and $currentValue.SmartScreenEnabled -ne $targetValue) {
  Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Value $targetValue -Type String -Force
  Write-Host "[0024_Disable_SmartScreen] - [WOW6432Node] SmartScreen SmartScreenEnabled value changed to $targetValue"
} else {
  Write-Host "[0024_Disable_SmartScreen] - [WOW6432Node] SmartScreen SmartScreenEnabled value is already on target"
}


