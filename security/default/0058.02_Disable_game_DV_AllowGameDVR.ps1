<#
.SYNOPSIS
Disables the Game DVR feature in Windows 10.

.DESCRIPTION
This script disables the Game DVR feature in Windows 10 by modifying the relevant registry keys. It checks if the necessary registry keys exist and if the current values are different from the target value. If the values need to be modified, it sets the new values and displays a corresponding message.

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

if (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR") {
  $allowGameDVR = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
  if ($allowGameDVR -ne $targetValue) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value $targetValue
    Write-Host "[0058.02_Disable_game_DV_AllowGameDVR] AllowGameDVR has been set to $targetValue."
  }
  else {
    Write-Host "[0058.02_Disable_game_DV_AllowGameDVR] AllowGameDVR is already set to $targetValue."
  }
}
else {
  Write-Host "[0058.02_Disable_game_DV_AllowGameDVR] GameDVR key does not exist."
}
