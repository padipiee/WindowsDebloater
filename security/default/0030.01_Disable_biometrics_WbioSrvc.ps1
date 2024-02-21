<#
.SYNOPSIS
Disables biometrics WbioSrvc on the Windows 10/11 system.

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
Write-Host "[0030.01_Disable_biometrics_WbioSrvc] Disable biometrics WbioSrvc"
$wbioSrvcKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\WbioSrvc"

if (Test-Path $wbioSrvcKeyPath) {
  $currentValue = (Get-ItemProperty -Path $wbioSrvcKeyPath -Name "Start").Start
  if ($currentValue -ne 4) {
    Write-Host "[0030.01_Disable_biometrics_WbioSrvc] Current value for $wbioSrvcKeyPath is $currentValue"
    Set-ItemProperty -Path $wbioSrvcKeyPath -Name "Start" -Value 4 -Type DWORD -Force
  }
  else {
    Write-Host "[0030.01_Disable_biometrics_WbioSrvc] Target value for $wbioSrvcKeyPath is already set"
  }
}
else {
  Write-Host "[0030.01_Disable_biometrics_WbioSrvc] Key does not exist: $wbioSrvcKeyPath"
}
