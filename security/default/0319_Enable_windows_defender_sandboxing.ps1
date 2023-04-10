# Check if Windows Defender sandboxing is activated
$sandboxingStatus = Get-MpPreference | Select-Object -ExpandProperty EnableControlledFolderAccess

if ($sandboxingStatus -eq 1) {
    Write-Host "Windows Defender sandboxing is already activated."
} else {
    # Activate Windows Defender sandboxing
    Set-MpPreference -EnableControlledFolderAccess 1

    # Verify if the activation was successful
    $sandboxingStatus = Get-MpPreference | Select-Object -ExpandProperty EnableControlledFolderAccess

    if ($sandboxingStatus -eq 1) {
        Write-Host "Windows Defender sandboxing has been successfully activated."
    } else {
        Write-Host "Failed to activate Windows Defender sandboxing."
    }
}
