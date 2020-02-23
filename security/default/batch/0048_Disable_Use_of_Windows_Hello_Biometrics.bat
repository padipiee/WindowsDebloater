echo Disable Use of Windows Hello Biometrics
REM Disable Use of Windows Hello Biometrics
REM HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics
REM Enabled DWORD ; 0 = Disable (delete) = Enable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f 