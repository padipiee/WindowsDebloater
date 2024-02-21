<#
.SYNOPSIS
Disables biometrics on the Windows 10/11 system.

.DESCRIPTION
This script disables biometrics on the Windows 10 system by modifying the registry keys related to biometrics settings. 
It checks if the necessary registry keys exist and if the current values are different from the target values. 
If the keys exist and the values need to be modified, the script updates the registry values accordingly.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disable-Biometrics

This example demonstrates how to use the script to disable biometrics on a Windows 10 system.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version Number]
#>
Write-Host "[0030_Disable_biometrics] Disable biometrics"
$biometricsKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics"
$targetValue = 0

if (Test-Path $biometricsKeyPath) {
  $currentValue = (Get-ItemProperty -Path $biometricsKeyPath -Name "Enabled").Enabled
  if ($currentValue -ne $targetValue) {
    Write-Host "[0030_Disable_biometrics] Current value for $biometricsKeyPath is $currentValue"
    Set-ItemProperty -Path $biometricsKeyPath -Name "Enabled" -Value $targetValue -Type DWORD -Force
  }
  else {
    Write-Host "[0030_Disable_biometrics] Target value for $biometricsKeyPath is already set"
  }
}
else {
  Write-Host "[0030_Disable_biometrics]  Key does not exist: $biometricsKeyPath"
}

