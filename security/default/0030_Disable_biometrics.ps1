Write-Host "[0030_Disable_biometrics] Disable biometrics"
$biometricsKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics"
$wbioSrvcKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\WbioSrvc"
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

if (Test-Path $wbioSrvcKeyPath) {
  $currentValue = (Get-ItemProperty -Path $wbioSrvcKeyPath -Name "Start").Start
  if ($currentValue -ne 4) {
    Write-Host "[0030_Disable_biometrics] Current value for $wbioSrvcKeyPath is $currentValue"
    Set-ItemProperty -Path $wbioSrvcKeyPath -Name "Start" -Value 4 -Type DWORD -Force
  }
  else {
    Write-Host "[0030_Disable_biometrics] Target value for $wbioSrvcKeyPath is already set"
  }
}
else {
  Write-Host "[0030_Disable_biometrics] Key does not exist: $wbioSrvcKeyPath"
}
