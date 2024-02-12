
# Disable Xbox Game Monitoring Windows 10 service
# http://batcmd.com/windows/10/services/xbgm/
# http://batcmd.com/windows/10/services/xbgm/
if (Test-Path "HKLM:\System\CurrentControlSet\Services\xbgm") {
    $startValue = (Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\xbgm" -Name "Start").Start
    if ($startValue -eq 4) {
        Write-Host "[0101_Disable_xbox_Game_monitoring_service_xbgm] The 'Start' value for Xbox Game Monitoring (xbgm) is already set to 'Disabled'."
    }
    else {
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\xbgm" -Name "Start" -Value 4
        Write-Host "[0101_Disable_xbox_Game_monitoring_service_xbgm] The 'Start' value for Xbox Game Monitoring (xbgm) has been set to 'Disabled'."
    }
}
else {
    Write-Host "[0101_Disable_xbox_Game_monitoring_service_xbgm] Xbox Game Monitoring (xbgm) is not installed."
}

$serviceName = "xbgm"
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "[0101_Disable_xbox_Game_monitoring_service_xbgm] Xbox Game Monitoring (xbgm) service found. Stopping the service..."
    Stop-Service -Name $serviceName
    Set-Service -Name $serviceName -StartupType Disabled
}
else {
    Write-Host "[0101_Disable_xbox_Game_monitoring_service_xbgm] Xbox Game Monitoring (xbgm) service not found."
}

# @REM ;;; 5.42 (L1) Ensure 'Xbox Game Monitoring (xbgm)' is set to 'Disabled'
# @REM ;[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\xbgm]
# @REM ; 2 = Automatic
# @REM ; 3 = Manual (Default)
# @REM ; 4 = Disabled (CIS)
# @REM ; NON-COMPLIANCE TO NOT DISRUPT COMMON HOME FEATURES
# @REM ;"Start"=dword:0000004


# @REM #Xbox Game Monitoring (xbgm)'
# @REM $indextest += 1
# @REM $chaine = $null
# @REM $traitement = $null
# @REM $exist = $null
# @REM $id = "SS" + "$indextest"
# @REM $chaine = "$id" + ";" + "(L1)Ensure Xbox Game Monitoring (xbgm) s set to 'Disabled' or 'Not Installed', value must be 4 or not installed" + ";"
# @REM $exist = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm"
# @REM if ( $exist -eq $true) {
# @REM  $traitement = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm"|Select-Object Start
# @REM  $traitement = $traitement.Start
# @REM }
# @REM else {
# @REM  $traitement = "It s not installed"
# @REM }