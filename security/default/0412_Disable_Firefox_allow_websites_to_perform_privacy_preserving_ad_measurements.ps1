# Define the path to the Firefox profile directory
$firefoxProfilePath = "$env:APPDATA\Mozilla\Firefox\Profiles"

# Get the profile directory (assuming there's only one profile)
$profileDir = Get-ChildItem -Path $firefoxProfilePath | Where-Object { $_.PSIsContainer } | Select-Object -First 1

# Define the path to the prefs.js file
$prefsFilePath = Join-Path -Path $profileDir.FullName -ChildPath "prefs.js"

# Define the preference to disable privacy-preserving ad measurement
$preference = 'user_pref("dom.private-attribution.submission.enabled", false);'

# Check if the preference already exists in the prefs.js file
$existingPreference = Get-Content -Path $prefsFilePath | Select-String -Pattern 'dom.private-attribution.submission.enabled'

if ($existingPreference) {
    Write-Output "Preference already exists. Updating the value..."
    # Update the existing preference
    (Get-Content -Path $prefsFilePath) -replace 'user_pref\("dom.private-attribution.submission.enabled", true\);', $preference | Set-Content -Path $prefsFilePath
} else {
    Write-Output "Adding new preference..."
    # Add the new preference to the prefs.js file
    Add-Content -Path $prefsFilePath -Value $preference
}

Write-Output "Privacy-preserving ad measurement feature has been disabled."
