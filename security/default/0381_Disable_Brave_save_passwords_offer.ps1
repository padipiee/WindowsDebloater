# Disable Brave Rewards
# This hides the Brave Rewards icon in the browser.
# Disable password saving in Brave Browser
# This script modifies the Brave configuration to prevent password saving prompts.

# Set the path to the Brave configuration file (change if needed)
$BraveConfigPath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Preferences"

# Read the existing configuration
$BraveConfig = Get-Content -Raw -Path $BraveConfigPath | ConvertFrom-Json

# Update the settings to disable password saving
$BraveConfig.password_manager_enabled = $false

# Save the modified configuration back to the file
$BraveConfig | ConvertTo-Json | Set-Content -Path $BraveConfigPath

Write-Host "[0381_Disable_Brave_save_passwords_offer] Password saving in Brave Browser has been disabled."
