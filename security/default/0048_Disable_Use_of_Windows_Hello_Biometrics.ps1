<#
.SYNOPSIS
Disables the use of Windows Hello Biometrics by modifying the registry.

.DESCRIPTION
This script disables the use of Windows Hello Biometrics by modifying the registry value for the specified path and value name. It checks if the registry path exists, tests the initial value, and sets the value to the specified disable value if needed.

.PARAMETER registryPath
The registry path where the value is located.

.PARAMETER registryValueName
The name of the registry value to be modified.

.PARAMETER disableValue
The value to set the registry value to in order to disable Windows Hello Biometrics.

.NOTES
- This script requires administrative privileges to modify the registry.
- Use with caution as modifying the registry can have unintended consequences.

.EXAMPLE
Disable-WindowsHelloBiometrics -registryPath "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" -registryValueName "Enabled" -disableValue 0
#>
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
if ($null -eq $initialValue) {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' does not exist."
} elseif ($initialValue.$registryValueName -eq $disableValue) {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' is already set to $disableValue."
} else {
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' is set to $($initialValue.$registryValueName)."
}

# Set the value only if needed
if ($null -eq $initialValue -or $initialValue.$registryValueName -ne $disableValue) {
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $disableValue -Type DWORD -Force
    Write-Host "[0048_Disable_Use_of_Windows_Hello_Biometrics] The registry value '$registryValueName' has been set to $disableValue."
}
