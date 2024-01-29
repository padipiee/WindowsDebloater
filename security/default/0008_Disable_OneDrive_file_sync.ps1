
<#
.SYNOPSIS
This script disables file synchronization for OneDrive.

.DESCRIPTION
The script disables various file synchronization settings for OneDrive by modifying the corresponding registry values.

.PARAMETER oneDrivePath
The registry path for OneDrive settings under HKEY_LOCAL_MACHINE.

.PARAMETER oneDriveUserPath
The registry path for OneDrive settings under HKEY_CURRENT_USER.

.EXAMPLE
.\0008_Disable_OneDrive_file_sync.ps1
Runs the script to disable OneDrive file synchronization.

#>

$oneDrivePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
$oneDriveUserPath = "HKCU:\SOFTWARE\Microsoft\OneDrive"

$disableFileSyncNGSC = Get-ItemPropertyValue -Path $oneDrivePath -Name "DisableFileSyncNGSC"
$disableFileSync = Get-ItemPropertyValue -Path $oneDrivePath -Name "DisableFileSync"
$disableMeteredNetworkFileSync = Get-ItemPropertyValue -Path $oneDrivePath -Name "DisableMeteredNetworkFileSync"
$disableLibrariesDefaultSaveToOneDrive = Get-ItemPropertyValue -Path $oneDrivePath -Name "DisableLibrariesDefaultSaveToOneDrive"
$disablePersonalSync = Get-ItemPropertyValue -Path $oneDriveUserPath -Name "DisablePersonalSync"

Write-Host "[0008_Disable_OneDrive_file_sync] Current values:"
Write-Host "[0008] DisableFileSyncNGSC: $disableFileSyncNGSC"
Write-Host "[0008] DisableFileSync: $disableFileSync"
Write-Host "[0008] DisableMeteredNetworkFileSync: $disableMeteredNetworkFileSync"
Write-Host "[0008] DisableLibrariesDefaultSaveToOneDrive: $disableLibrariesDefaultSaveToOneDrive"
Write-Host "[0008] DisablePersonalSync: $disablePersonalSync"

$targetValue = 1

if ($disableFileSyncNGSC -ne $targetValue) {
  Set-ItemProperty -Path $oneDrivePath -Name "DisableFileSyncNGSC" -Value $targetValue
  Write-Host "[0008] DisableFileSyncNGSC has been updated to $targetValue"
}
else {
  Write-Host "[0008] DisableFileSyncNGSC is already set to $targetValue"
}

if ($disableFileSync -ne $targetValue) {
  Set-ItemProperty -Path $oneDrivePath -Name "DisableFileSync" -Value $targetValue
  Write-Host "[0008] DisableFileSync has been updated to $targetValue"
}
else {
  Write-Host "[0008] DisableFileSync is already set to $targetValue"
}

if ($disableMeteredNetworkFileSync -ne $targetValue) {
  Set-ItemProperty -Path $oneDrivePath -Name "DisableMeteredNetworkFileSync" -Value $targetValue
  Write-Host "[0008] DisableMeteredNetworkFileSync has been updated to $targetValue"
}
else {
  Write-Host "[0008] DisableMeteredNetworkFileSync is already set to $targetValue"
}

if ($disableLibrariesDefaultSaveToOneDrive -ne $targetValue) {
  Set-ItemProperty -Path $oneDrivePath -Name "DisableLibrariesDefaultSaveToOneDrive" -Value $targetValue
  Write-Host "[0008] DisableLibrariesDefaultSaveToOneDrive has been updated to $targetValue"
}
else {
  Write-Host "[0008] DisableLibrariesDefaultSaveToOneDrive is already set to $targetValue"
}

if ($disablePersonalSync -ne $targetValue) {
  Set-ItemProperty -Path $oneDriveUserPath -Name "DisablePersonalSync" -Value $targetValue
  Write-Host "[0008] DisablePersonalSync has been updated to $targetValue"
}
else {
  Write-Host "[0008] DisablePersonalSync is already set to $targetValue"
}
