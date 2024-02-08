
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
if (!(Test-Path $registryPath)) {
  Write-Host "[0031_Disable_Program_Compatibility_Assistant] - Registry folder $registryPath does not exist. Exiting..."
  exit
}

$registryValueName = "DisablePCA"
$targetValue = 1

$currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $registryValueName

if ($currentValue -ne $targetValue) {
  Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue -Force
  $message = "[0031_Disable_Program_Compatibility_Assistant] The value of '$registryValueName' has been set to $targetValue."
} else {
  $message = "[0031_Disable_Program_Compatibility_Assistant] The value of '$registryValueName' is already set to $targetValue."
}

Write-Host $message
