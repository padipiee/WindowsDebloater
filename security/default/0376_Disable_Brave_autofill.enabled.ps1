# Define the path to the Preferences file
$preferencesPath = "$env:USERPROFILE\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Preferences"

# Read the file content
$json = Get-Content -Path $preferencesPath | ConvertFrom-Json

# Modify a setting
$json.autofill.enabled = $false

# Write the changes back to the file
$json | ConvertTo-Json | Set-Content -Path $preferencesPath