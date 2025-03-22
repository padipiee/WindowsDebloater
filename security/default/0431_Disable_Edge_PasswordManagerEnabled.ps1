# Path to the Edge policies registry key
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the PasswordManagerEnabled policy to 0 (disable)
$registryName = "PasswordManagerEnabled"

# Get the current value of the setting
$currentValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName

# Set the policy only if it's not already disabled
if ($currentValue -ne 0) {
    Set-ItemProperty -Path $registryPath -Name $registryName -Value 0
    Write-Output "PasswordManagerEnabled policy has been set to 0 (disabled)."
} else {
    Write-Output "PasswordManagerEnabled policy is already set to 0 (disabled)."
}
