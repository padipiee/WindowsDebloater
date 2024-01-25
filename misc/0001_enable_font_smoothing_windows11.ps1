<#
.SYNOPSIS
Enables font smoothing in Windows 11.

.DESCRIPTION
This script enables font smoothing in Windows 11 by modifying the registry settings.

.PARAMETER None

.EXAMPLE
Enable-FontSmoothingWindows11

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

$fontSmoothing = Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name FontSmoothing -ErrorAction SilentlyContinue
$fontSmoothingType = Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name FontSmoothingType -ErrorAction SilentlyContinue

if ($null -eq $fontSmoothing -or 1 -ne $fontSmoothing.FontSmoothing -or $null -eq $fontSmoothingType -or 2 -ne $fontSmoothingType.FontSmoothingType) {
  Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name FontSmoothing -Value 1
  Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name FontSmoothingType -Value 2
  Write-Host "Font smoothing settings have been enabled."
} else {
  Write-Host "Font smoothing settings are already set."
}
