# Define the path to the Brave browser's user data directory
$braveUserDataPath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default"

# Define the path to the Preferences file
$preferencesFile = Join-Path -Path $braveUserDataPath -ChildPath "Preferences"

# Check if the Preferences file exists
if (Test-Path -Path $preferencesFile) {
    # Read the contents of the Preferences file
    $preferencesContent = Get-Content -Path $preferencesFile -Raw

    # Convert the JSON content to a PowerShell object
    $preferencesObject = $preferencesContent | ConvertFrom-Json

    # Set the stats_updater_url to an empty string to disable stats
    $preferencesObject.brave.stats_updater_url = ""

    # Convert the PowerShell object back to JSON
    $updatedPreferencesContent = $preferencesObject | ConvertTo-Json -Depth 10

    # Write the updated JSON content back to the Preferences file
    $updatedPreferencesContent | Set-Content -Path $preferencesFile
}

# Output completion message
Write-Host "[0391_Disable_Brave_stats] Brave stats have been hidden."
