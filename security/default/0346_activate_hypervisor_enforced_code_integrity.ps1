<#
.SYNOPSIS
Checks if the Hypervisor Enforced Code Integrity feature is activated.

.DESCRIPTION
This script checks if the Hypervisor Enforced Code Integrity feature is activated by reading the registry value "Enabled" under the registry path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity". If the value is not found or is set to 0, the feature is considered not activated. If the value is set to 1, the feature is considered activated.

.NOTES
File Name: 0346_activate_hypervisor_enforced_code_integrity.ps1
Author   : Unknown
#>

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
$registryValue = "Enabled"

$value = Get-ItemPropertyValue -Path $registryPath -Name $registryValue -ErrorAction Stop

# Check if the value exists
if ($null -eq $value) {
  Write-Output "Hypervisor Enforced Code Integrity feature is not activated."
}
else {
  # Check if the value is 0 (not activated) or 1 (activated)
  if ($value.Enabled -eq 0) {
    Write-Output "Hypervisor Enforced Code Integrity feature is not activated."
  }
  else {
    Write-Output "Hypervisor Enforced Code Integrity feature is activated."
  }
}



