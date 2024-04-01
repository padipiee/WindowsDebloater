
# Rationale : if either any password was saved in the Clipboard history then ...
# any secure password manager is kind of bypassed

# Define the path and name for the Clipboard History registry setting
$registryPath = "HKCU:\Software\Microsoft\Clipboard"
$registryName = "EnableClipboardHistory"

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force | Out-Null
}

# Check the current state of Clipboard History
$currentValue = Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue

if ($currentValue -and $currentValue.EnableClipboardHistory -eq 1) {
    # Disable Clipboard History if it is currently enabled
    Set-ItemProperty -Path $registryPath -Name $registryName -Value 0
    Write-Host "[0393_Disable_AllowClipboardHistory] Clipboard History has been disabled."
} elseif ($currentValue -and $currentValue.EnableClipboardHistory -eq 0) {
    Write-Host "[0393_Disable_AllowClipboardHistory] Clipboard History is already disabled."
} else {
    # The registry value does not exist, implying Clipboard History is not explicitly disabled. Let's disable it.
    Set-ItemProperty -Path $registryPath -Name $registryName -Value 0
    Write-Host "[0393_Disable_AllowClipboardHistory] Clipboard History was not explicitly disabled. It has now been disabled."
}

# Optionally, you might want to notify users to log off or restart for changes to take effect
# Write-Host "Please log off or restart your computer for the changes to take effect."
