
:: Prevent Local windows wireless exploitation: the Airstrike attack https://shenaniganslabs.io/2021/04/13/Airstrike.html

reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DontDisplayNetworkSelectionUI /t REG_DWORD /d 1 /f
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System"




@REM # Hide network options from Lock Screen
@REM Function HideNetworkFromLockScreen {
@REM 	Write-Output "Hiding network options from Lock Screen..."
@REM 	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DontDisplayNetworkSelectionUI" -Type DWord -Value 1
@REM }

@REM # Show network options on lock screen
@REM Function ShowNetworkOnLockScreen {
@REM 	Write-Output "Showing network options on Lock Screen..."
@REM 	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DontDisplayNetworkSelectionUI" -ErrorAction SilentlyContinue
@REM }


@REM ;;; 18.8.27.2 (L1) Ensure 'Do not display network selection UI' is set to 'Enabled'
@REM [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
@REM ; <deleted> = (Default)
@REM ; 0000000 = Off
@REM ; 0000001 = On (CIS)
@REM "DontDisplayNetworkSelectionUI"=dword:0000001

      @REM # 18.8.28.2 (L1) Ensure 'Do not display network selection UI' is set to 'Enabled'
      @REM Registry 'DontDisplayNetworkSelectionUI' {
      @REM     Ensure     = 'Present'
      @REM     Key        = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System'
      @REM     ValueName  = 'DontDisplayNetworkSelectionUI'
      @REM     ValueType  = 'DWord'
      @REM     ValueData  = '1'
      @REM }


@REM #Do not display network selection UI
@REM $indextest += 1
@REM $chaine = $null
@REM $traitement = $null
@REM $id = "LOGON" + "$indextest"
@REM $chaine = "$id" + ";" + "(L1)Ensure Do not display network selection UI is set to Enabled, value must be 1 " + ";"
@REM $exist = Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
@REM if ( $exist -eq $true) {
@REM  $traitement = Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" |Select-Object DontDisplayNetworkSelectionUI
@REM  $traitement = $traitement.DontDisplayNetworkSelectionUI
@REM }
@REM else {
@REM  $traitement = "not configure"
@REM }
@REM $chaine += $traitement
@REM $chaine>> $nomfichier


