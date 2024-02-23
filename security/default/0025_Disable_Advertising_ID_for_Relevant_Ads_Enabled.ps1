# Disable Advertising ID for Relevant Ads
# Advertising ID Let Apps use for Relevant Ads in Windows 10...
# Windows Registry Editor Version 5.00
# [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
# "Enabled"=dword:00000000
# Enabled = 1 - the feature is enabled : you share the Ad ID...
# Enabled = 0 - the feature is disabled.

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
$propertyName = "Enabled"
$targetValue = 0
$modified = $false

if (Test-Path $registryPath) {
  $propertyValue = Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue
  if ($null -eq $propertyValue) {
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value $targetValue -Type DWORD -Force
    $modified = $true
  }
  else {
    if ($propertyValue.$propertyName -ne $targetValue) {
      Set-ItemProperty -Path $registryPath -Name $propertyName -Value $targetValue -Type DWORD -Force
      $modified = $true
    }
  }
}
else {
  Write-Host "[0025_Disable_Advertising_ID_for_Relevant_Ads_Enabled] Registry path not found: $registryPath"
}

if (-not $modified) {
  Write-Host "[0025_Disable_Advertising_ID_for_Relevant_Ads_Enabled [no change] $registryPath $propertyName = $targetValue"
}
