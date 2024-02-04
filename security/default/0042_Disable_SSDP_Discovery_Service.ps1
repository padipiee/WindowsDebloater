
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\services\SSDPSRV"
$targetValue = 4

if (Test-Path $registryPath) {
  $currentValue = Get-ItemProperty -Path $registryPath -Name "Start" | Select-Object -ExpandProperty "Start"
  
  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $registryPath -Name "Start" -Value $targetValue
    Write-Host "[0042_Disable_SSDP_Discovery_Service] The value of $registryPath 'Start' has been updated to $targetValue."
  } else {
    Write-Host "[0042_Disable_SSDP_Discovery_Service] The value of $registryPath 'Start' is already set to $targetValue."
  }
} else {
  Write-Host "[0042_Disable_SSDP_Discovery_Service] The registry key $registryPath does not exist."
}
