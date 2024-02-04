$targetValue = 0

if (Test-Path "HKCU:\System\GameConfigStore") {
  $gameDVR_Enabled = Get-ItemPropertyValue -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -ErrorAction SilentlyContinue
  if ($gameDVR_Enabled -ne $targetValue) {
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value $targetValue
    Write-Host "[0058_Disable_game_DVR] Game DVR has been disabled."
  }
  else {
    Write-Host "[0058_Disable_game_DVR] Game DVR is already disabled."
  }
}
else {
  Write-Host "[0058_Disable_game_DVR] Game DVR key does not exist."
}

if (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR") {
  $allowGameDVR = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
  if ($allowGameDVR -ne $targetValue) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value $targetValue
    Write-Host "[0058_Disable_game_DVR] AllowGameDVR has been set to $targetValue."
  }
  else {
    Write-Host "[0058_Disable_game_DVR] AllowGameDVR is already set to $targetValue."
  }
}
else {
  Write-Host "[0058_Disable_game_DVR] GameDVR key does not exist."
}
