$registryPath = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics"
$registryValueName = "Enabled"
$disableValue = 0

# Check if registry path exists
if (Test-Path -Path $registryPath) {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry path '$registryPath' exists."
} else {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry path '$registryPath' does not exist. Exiting..."
    return
}

# Test the initial value
$initialValue = Get-ItemProperty -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue
if ($initialValue -eq $null) {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' does not exist."
} elseif ($initialValue.$registryValueName -eq $disableValue) {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' is already set to $disableValue."
} else {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' is set to $($initialValue.$registryValueName)."
}

# Set the value only if needed
if ($initialValue -eq $null -or $initialValue.$registryValueName -ne $disableValue) {
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $disableValue -Type DWORD -Force
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' has been set to $disableValue."
}
