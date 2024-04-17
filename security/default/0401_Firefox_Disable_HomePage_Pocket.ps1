# Improved PowerShell script to configure the DisablePocket policy for Firefox via Windows Registry
# This version adds error handling to avoid errors when the DisablePocket property does not exist.

# Define the registry path for Firefox policies
$registryPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"
$title = "[0401_Firefox_Disable_HomePage_Pocket]"

# Ensure the Firefox policy path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Created Firefox policy registry path."
}

# Initialize variable to check if DisablePocket exists
$disablePocketExists = $false
$disablePocketValue = $null

# Check if the DisablePocket policy already exists
try {
    $disablePocketValue = Get-ItemPropertyValue -Path $registryPath -Name "DisablePocket" -ErrorAction Stop
    $disablePocketExists = $true
} catch {
    # Catch block left intentionally empty
}

if (-not $disablePocketExists) {
    # The DisablePocket policy does not exist, create it and set its value to 1
    New-ItemProperty -Path $registryPath -Name "DisablePocket" -Value 1 -PropertyType DWord -Force | Out-Null
    Write-Host "$title The DisablePocket policy has been created and disabled Pocket in Firefox."
} elseif ($disablePocketValue -eq 1) {
    # The DisablePocket policy already exists and is set to the correct value
    Write-Host "$title  The DisablePocket policy already exists and is correctly set to disable Pocket in Firefox. No changes made."
} else {
    # The DisablePocket policy exists but is not set to the correct value, update it
    Set-ItemProperty -Path $registryPath -Name "DisablePocket" -Value 1
    Write-Host "$title The DisablePocket policy has been updated to disable Pocket in Firefox."
}
