
:: Enforce screen locking
:: https://www.stigviewer.com/stig/windows_server_20122012_r2_domain_controller/2017-06-09/finding/V-36773
:: https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit
:: https://www.tenforums.com/tutorials/118314-automatically-lock-computer-when-idle-specified-time-windows-10-a.html
:: https://www.kapilarya.com/how-to-automatically-lock-computer-after-inactivity-in-windows-11
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "InactivityTimeoutSecs" /t REG_DWORD /d 300 /f



@REM #Interactive logon: Machine inactivity limit'

@REM $indextest += 1
@REM $chaine = $null
@REM $traitement = $null
@REM $exist = $null
@REM $id = "IL" + "$indextest"
@REM $chaine = "$id" + ";" + "(L1)Ensure Interactive logon: Machine inactivity limit' is set to 900 or fewer second(s), but not 0 " + ";"
@REM $exist = Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
@REM if ( $exist -eq $true) {
@REM  $traitement = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System |Select-Object InactivityTimeoutSecs
@REM  $traitement = $traitement.InactivityTimeoutSecs
@REM }
@REM else {
@REM  $traitement = "not configure"
@REM }

@REM ;;; 2.3.7.4 (L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but not 0'
@REM [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System]
@REM ; <deleted> = (Default)
@REM ; 0000000 = Off
@REM ; 0000384 = 900 seconds, 15 minutes (CIS)
@REM "InactivityTimeoutSecs"=dword:0000384


@REM powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 300
@REM powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 300
@REM powercfg.exe /setactive SCHEME_CURRENT

@REM #cmd 
@REM REG ADD 'HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\7516b95f-f776-4464-8c53-06167f40cc99\8EC4B3A5-6868-48c2-BE75-4F3044BE88A7' /v Attributes /t REG_DWORD /d 00000002 /