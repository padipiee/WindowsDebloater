
:: Disable Xbox Game Monitoring Windows 10 service
:: http://batcmd.com/windows/10/services/xbgm/
:: http://batcmd.com/windows/10/services/xbgm/
:: reg query "HKLM\System\CurrentControlSet\Services\xbgm"
reg add "HKLM\System\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f

sc.exe stop xbgm
sc.exe config xbgm start= disabled

@REM ;;; 5.42 (L1) Ensure 'Xbox Game Monitoring (xbgm)' is set to 'Disabled'
@REM ;[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\xbgm]
@REM ; 2 = Automatic
@REM ; 3 = Manual (Default)
@REM ; 4 = Disabled (CIS)
@REM ; NON-COMPLIANCE TO NOT DISRUPT COMMON HOME FEATURES
@REM ;"Start"=dword:0000004


@REM #Xbox Game Monitoring (xbgm)'
@REM $indextest += 1
@REM $chaine = $null
@REM $traitement = $null
@REM $exist = $null
@REM $id = "SS" + "$indextest"
@REM $chaine = "$id" + ";" + "(L1)Ensure Xbox Game Monitoring (xbgm) s set to 'Disabled' or 'Not Installed', value must be 4 or not installed" + ";"
@REM $exist = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm"
@REM if ( $exist -eq $true) {
@REM  $traitement = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm"|Select-Object Start
@REM  $traitement = $traitement.Start
@REM }
@REM else {
@REM  $traitement = "It s not installed"
@REM }