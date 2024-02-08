<#
.SYNOPSIS
Disables Application Telemetry if it is enabled.

.DESCRIPTION
This script checks if the Application Telemetry is enabled in the Windows registry and disables it if necessary. It specifically looks for the "AITEnable" value under the "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" registry key. If the value is already set to 0 (disabled), no changes are made. If the value is set to any other value, it is updated to 0 to disable Application Telemetry.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disable-ApplicationTelemetry

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>

$AppCompatPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
if (!(Test-Path $AppCompatPath)) {
  Write-Host "[0017_Disable_Application_Telemetry] - Registry folder $AppCompatPath does not exist. Exiting..."
  exit
}

$propertyName = "AITEnable"
if (Test-Path -Path $AppCompatPath) {
  if (Get-ItemProperty -Path $AppCompatPath -Name $propertyName -ErrorAction SilentlyContinue) {
    $item = Get-ItemProperty -Path $AppCompatPath -Name $propertyName
    if ($item.$propertyName -eq 0) {
      Write-Host "[0017_Disable_Application_Telemetry] Application Telemetry is already disabled ($propertyName) [no change]"
    }
    else {
      Write-Host "[0017_Disable_Application_Telemetry] Application Telemetry is currently set to $($item.$propertyName)"
      Set-ItemProperty -Path $AppCompatPath -Name $propertyName -Value 0
      Write-Host "[0017_Disable_Application_Telemetry] Application Telemetry has been disabled"
    }
  }
  else {
    Write-Host "[0017_Disable_Application_Telemetry] Application Telemetry is not configured [no change]"
  }
}
else {
  Write-Host "[0017_Disable_Application_Telemetry] Registry folder $AppCompatPath does not exist. Exiting..."
  return
}
