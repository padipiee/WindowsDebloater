#0 = Off
#1 = On
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
$registryProperty = "Enabled"

if (Test-Path -Path $registryPath) {
  $initialValue = (Get-ItemProperty -Path $registryPath -Name $registryProperty).$registryProperty

  if ($initialValue -ne 0) {
    Set-ItemProperty -Path $registryPath -Name $registryProperty -Value 0
    Write-Host "[0020_Disable_Advertising_ID] CurrentVersion\AdvertisingInfo was set to 0"
  }
  else {
    Write-Host "[0020_Disable_Advertising_ID] CurrentVersion\AdvertisingInfo was already set [no change]"
  }
}
else {
  Write-Host "[0020_Disable_Advertising_ID] CurrentVersion\AdvertisingInfo path does not exist"
}

#Enabled Value 1
#Disabled Value 0
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
$registryProperty = "DisabledByGroupPolicy"

if (Test-Path -Path $registryPath) {
  $initialValue = (Get-ItemProperty -Path $registryPath -Name $registryProperty).$registryProperty

  if ($initialValue -ne 1) {
    Set-ItemProperty -Path $registryPath -Name $registryProperty -Value 1
    Write-Host "[0020_Disable_Advertising_ID] Windows\AdvertisingInfo was set to 1"
  }
  else {
    Write-Host "[0020_Disable_Advertising_ID] Windows\AdvertisingInfo was already set [no change]"
  }
}
else {
  Write-Host "[0020_Disable_Advertising_ID] Windows\AdvertisingInfo path does not exist"
}
