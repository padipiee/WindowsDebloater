# Disable Brave Rewards
# This hides the Brave Rewards icon in the browser.
# Disable password saving in Brave Browser
# This script modifies the Brave configuration to prevent password saving prompts.

try {
    # Set the path to the Brave configuration file (change if needed)
    $BraveConfigPath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Preferences"

    # Check if the configuration file exists
    if (Test-Path $BraveConfigPath) {
        # Read the existing configuration
        $BraveConfig = Get-Content -Raw -Path $BraveConfigPath | ConvertFrom-Json -Depth 20

        # Initialize necessary objects if they don't exist
        if (-not $BraveConfig.profile) {
            $BraveConfig | Add-Member -MemberType NoteProperty -Name "profile" -Value ([PSCustomObject]@{})
        }
        
        if (-not $BraveConfig.profile.password_manager_enabled) {
            $BraveConfig.profile | Add-Member -MemberType NoteProperty -Name "password_manager_enabled" -Value $true
        }

        # Update the settings to disable password saving
        $BraveConfig.profile.password_manager_enabled = $false

        # Save the modified configuration back to the file
        $BraveConfig | ConvertTo-Json -Depth 20 | Set-Content -Path $BraveConfigPath

        Write-Host "[0381_Disable_Brave_save_passwords_offer] Password saving in Brave Browser has been disabled."
    } else {
        Write-Host "[0381_Disable_Brave_save_passwords_offer] Brave Browser preferences file not found at: $BraveConfigPath"
    }
} catch {
    Write-Host "[0381_Disable_Brave_save_passwords_offer] Error: $_"
}
