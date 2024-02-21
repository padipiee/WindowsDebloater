<#
.SYNOPSIS
Disables the Game DVR feature (GameDVR_Enabled") in Windows 10/11

.DESCRIPTION
This script disables the Game DVR feature in Windows 10/11 by modifying the relevant registry keys. It checks if the necessary registry keys exist and if the current values are different from the target value. If the values need to be modified, it sets the new values and displays a corresponding message.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
Disable-GameDVR
This command runs the script to disable the Game DVR feature.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version]
#>

$targetValue = 0

if (Test-Path "HKCU:\System\GameConfigStore") {
  $gameDVR_Enabled = Get-ItemPropertyValue -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -ErrorAction SilentlyContinue
  if ($gameDVR_Enabled -ne $targetValue) {
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value $targetValue
    Write-Host "[0058.01_Disable_game_DVR_GameDVR_Enabled] Game DVR has been disabled."
  }
  else {
    Write-Host "[0058.01_Disable_game_DVR_GameDVR_Enabled] Game DVR is already disabled."
  }
}
else {
  Write-Host "[0058.01_Disable_game_DVR_GameDVR_Enabled] Game DVR key does not exist."
}


