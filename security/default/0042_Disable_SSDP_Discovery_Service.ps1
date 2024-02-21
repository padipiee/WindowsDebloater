<#
.SYNOPSIS
Disables the SSDP Discovery Service by modifying the registry.

.DESCRIPTION
This script disables the SSDP Discovery Service by modifying the registry value of 'Start' under the registry path 'HKLM:\SYSTEM\CurrentControlSet\services\SSDPSRV'. If the registry key does not exist, a message will be displayed.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disable-SSDPDiscoveryService
#>

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
