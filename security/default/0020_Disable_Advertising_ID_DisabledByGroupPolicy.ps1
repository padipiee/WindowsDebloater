<#
.SYNOPSIS
Disables the Advertising ID feature in Windows 10/11.

.DESCRIPTION
This script disables the Advertising ID feature in Windows 10 by modifying the corresponding registry keys.
The Advertising ID is used by Microsoft to personalize ads and recommendations on Windows devices.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disable-AdvertisingID

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>

#Enabled Value 1
#Disabled Value 0
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
$registryProperty = "DisabledByGroupPolicy"

if (Test-Path -Path $registryPath) {
  $initialValue = (Get-ItemProperty -Path $registryPath -Name $registryProperty).$registryProperty

  if ($initialValue -ne 1) {
    Set-ItemProperty -Path $registryPath -Name $registryProperty -Value 1
    Write-Host "[0020_Disable_Advertising_ID_DisabledByGroupPolicy] Windows\AdvertisingInfo $registryProperty  was set to 1"
  }
  else {
    Write-Host "[0020_Disable_Advertising_ID_DisabledByGroupPolicy] Windows\AdvertisingInfo $registryProperty  was already set [no change]"
  }
}
else {
  Write-Host "[0020_Disable_Advertising_ID_DisabledByGroupPolicy] Windows\AdvertisingInfo path does not exist"
}
