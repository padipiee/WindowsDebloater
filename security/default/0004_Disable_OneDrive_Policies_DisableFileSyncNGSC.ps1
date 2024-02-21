<#
.SYNOPSIS
Disables OneDrive file synchronization in HKLM Policies\Microsoft\Windows\OneDrive.

.DESCRIPTION
This script disables OneDrive file synchronization by setting the 'DisableFileSyncNGSC' registry value to 1.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE

This example runs the script to disable OneDrive file synchronization.

#>
$targetMessage = "[0004_Disable_OneDrive_Policies_DisableFileSyncNGSC] [no change] [compliant] No action completed, already on target"

$oneDrivePath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive'

if (!(Test-Path $oneDrivePath)) {
    Write-Host "[0004_Disable_OneDrive_Policies_DisableFileSyncNGSC] - Registry folder does not exist. Exiting..."
    return
}

if (Test-Path $oneDrivePath) {
    $disableFileSyncNGSC = Get-ItemPropertyValue -Path $oneDrivePath -Name "DisableFileSyncNGSC" -ErrorAction SilentlyContinue

    if ($null -ne $disableFileSyncNGSC -and $disableFileSyncNGSC -ne 1) {
        Set-ItemProperty -Path $oneDrivePath -Name "DisableFileSyncNGSC" -Value 1
        Write-Host "[0004_Disable_OneDrive_Policies_DisableFileSyncNGSC]  - OneDrive file synchronization disabled"
    }
    elseif ($disableFileSyncNGSC -eq 1) {
        Write-Host "[0004_Disable_OneDrive_Policies_DisableFileSyncNGSC] - OneDrive file synchronization is already disabled"
    }
    else {
        Write-Host "[0004_Disable_OneDrive_Policies_DisableFileSyncNGSC] - Unable to retrieve registry property value"
    }
}
else {
    Write-Host "[0008_Disable_OneDrive_file_sync] Path tested: $oneDrivePath"
    Write-Host $targetMessage
}