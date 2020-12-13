echo Disable Use of Windows Hello Biometrics
:: Disable Use of Windows Hello Biometrics
:: HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics
:: Enabled DWORD ; 0 = Disable (delete) = Enable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f 