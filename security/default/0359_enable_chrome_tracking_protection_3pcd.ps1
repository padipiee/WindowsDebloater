<#
.SYNOPSIS
Enables tracking protection in Google Chrome by modifying the Preferences file.

.DESCRIPTION
This script enables the tracking protection feature in Google Chrome by modifying the Preferences file. It backs up the original Preferences file, reads and parses it, modifies the necessary flag, converts it back to JSON, and writes it back to the file. It then closes all running instances of Chrome to apply the changes and restarts Chrome.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Enable-TrackingProtection

This example demonstrates how to use the script to enable tracking protection in Google Chrome.

.NOTES
Author: 
Date: 
Version: 1.0
#>
$chromeProfilePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
$preferencesPath = Join-Path -Path $chromeProfilePath -ChildPath "Preferences"

# Backup the original Preferences file
Copy-Item -Path $preferencesPath -Destination "$preferencesPath.backup" -Force

# Read and parse the Preferences file
if (Test-Path -Path $preferencesPath) {
  $preferences = Get-Content -Path $preferencesPath -Raw | ConvertFrom-Json

  # Modify the flag (This is a simplified example, actual implementation might differ)
  $preferences.flags = @{tracking_protection_3pcd = "Enabled" }

  # Convert back to JSON and write to file
  $preferences | ConvertTo-Json | Set-Content -Path $preferencesPath
}
else {
  Write-Warning "Chrome Preferences file not found."
}

# Close all running instances of Chrome to apply changes
Get-Process -Name "chrome" | ForEach-Object { $_.CloseMainWindow() }

# Restart Chrome
Start-Process "chrome.exe"

