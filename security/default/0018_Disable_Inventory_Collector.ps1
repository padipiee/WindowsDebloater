<#
.SYNOPSIS
Disables the Inventory Collector feature in Windows.

.DESCRIPTION
This script disables the Inventory Collector feature in Windows by modifying the corresponding registry key.
It checks the initial value of the 'DisableInventory' property in the registry and sets it to 1 if it is not already set.

.PARAMETER None

.EXAMPLE
.\0018_Disable_Inventory_Collector.ps1
This command runs the script and disables the Inventory Collector feature.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version Number]
#>
# Disable Inventory Collector
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$propertyName = "DisableInventory"
$initialValue = Get-ItemProperty -Path $registryPath -Name $propertyName

if ($null -eq $initialValue) {
  Write-Host "[0018_Disable_Inventory_Collector] The property '$propertyName' does not exist in the registry."
}
else {
  Write-Host "[0018_Disable_Inventory_Collector] The initial value of '$propertyName' is $($initialValue.$propertyName)."
}

if ($null -eq $initialValue -or $initialValue.$propertyName -ne 1) {
  Set-ItemProperty -Path $registryPath -Name $propertyName -Value 1
  Write-Host "[0018_Disable_Inventory_Collector] The value of '$propertyName' has been set to 1."
}
else {
  Write-Host "[0018_Disable_Inventory_Collector] The value of '$propertyName' is already 1. [No change]"
}

