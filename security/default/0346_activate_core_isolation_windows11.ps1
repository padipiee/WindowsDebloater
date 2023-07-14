# Check current configuration
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
$registryValue = "Enabled"
$registryKey = Get-ItemProperty -Path $registryPath -Name $registryValue

if ($registryKey.Enabled -eq 0) {
  Write-Output "Windows Core Isolation feature is not activated."
  # Activate Windows Core Isolation feature
  Set-ItemProperty -Path $registryPath -Name $registryValue -Value 1
  Write-Output "Windows Core Isolation feature has been activated."
}
else {
  Write-Output "Windows Core Isolation feature is already activated."
}
