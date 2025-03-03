# Define the path to the Firefox profile directory
$firefoxProfilePath = "$env:APPDATA\Mozilla\Firefox\Profiles"

# Get the profile directory (assuming there's only one profile)
$profileDir = Get-ChildItem -Path $firefoxProfilePath | Where-Object { $_.PSIsContainer } | Select-Object -First 1

# Define the path to the prefs.js file
$prefsFilePath = Join-Path -Path $profileDir.FullName -ChildPath "prefs.js"

# Define the preference to disable privacy-preserving ad measurement
$preference = 'user_pref("dom.private-attribution.submission.enabled", false);'

# Read the prefs.js content
$prefsContent = Get-Content -Path $prefsFilePath
if ($prefsContent -match 'user_pref\("dom.private-attribution.submission.enabled", false\);') {
    Write-Host "Privacy-preserving ad measurement is already disabled."
} elseif ($prefsContent -match 'user_pref\("dom.private-attribution.submission.enabled", true\);') {
    Write-Host "Preference set to true. Replacing with false..."
    ($prefsContent -replace 'user_pref\("dom.private-attribution.submission.enabled", true\);', $preference) | Set-Content -Path $prefsFilePath
} else {
    Write-Host "Preference not found. Adding new entry..."
    Add-Content -Path $prefsFilePath -Value $preference
    Write-Host "Privacy-preserving ad measurement feature check complete."
}

