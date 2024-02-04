$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
$registryValueName = "SystemPaneSuggestionsEnabled"
$targetValue = 0

if (Test-Path $registryPath) {
  $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName | Select-Object -ExpandProperty $registryValueName

  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue
    Write-Host "[0037_Disable_Windows_Consumer_Features] Value for $registryPath $registryValueName updated to $targetValue"
  }
  else {
    Write-Host "[0037_Disable_Windows_Consumer_Features] Value for $registryPath $registryValueName  is already set to $targetValue"
  }
}
else {
  Write-Host "[0037_Disable_Windows_Consumer_Features] Registry path $registryPath does not exist"
}
