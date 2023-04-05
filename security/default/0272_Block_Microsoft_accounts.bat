:: Privacy (optional) - Disable Microsoft account user authentication.

::TO BE CONSIDERED BEFORE ACTIVATING
:: reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoConnectedUser" /t REG_DWORD /d 3 /f
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v NoConnectedUser /t REG_DWORD /d 3 /f

@REM #Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts
@REM $indextest += 1
@REM $chaine = $null
@REM $traitement = $null
@REM $exist = $null
@REM $id = "AA" + "$indextest"
@REM $chaine = "$id" + ";" + "(CIS L1)Accounts: Block Microsoft accounts is set to Users cant add or log on with Microsoft accounts Value must be 3 " + ";"
@REM $exist = Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
@REM if ( $exist -eq $true) {
@REM  $traitement = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System | Select-Object NoConnectedUser
@REM  $traitement = $traitement.NoConnectedUser
@REM }
@REM else {
@REM  $traitement = "not configure"
@REM }

@REM ;;; 2.3.1.2 (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'
@REM ;[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System]
@REM ; <deleted> = (Default)
@REM ; 0000000 = This policy is disabled
@REM ; 0000001 = Users can’t add Microsoft accounts
@REM ; 0000003 = Users can’t add or log on with Microsoft accounts (CIS)
@REM ; NON-COMPLIANCE TO NOT DISRUPT COMMON HOME FEATURES
@REM ;"NoConnectedUser"=dword:0000003