# Check if Windows Defender PUAProtection is enabled
$PUAProtectionStatus = Get-MpPreference | Select-Object -ExpandProperty PUAProtection

if ($PUAProtectionStatus -eq 1) {
    Write-Host "Windows Defender PUAProtection is already enabled."
} else {
    # Enable Windows Defender PUAProtection
    Set-MpPreference -PUAProtection 1

    # Verify if the activation was successful
    $PUAProtectionStatus = Get-MpPreference | Select-Object -ExpandProperty PUAProtection

    if ($PUAProtectionStatus -eq 1) {
        Write-Host "Windows Defender PUAProtection has been successfully enabled."
    } else {
        Write-Host "Failed to enable Windows Defender PUAProtection."
    }
}
