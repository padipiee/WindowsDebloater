:: @N@Enable_Notififications_Internet_explorer_SafeForScripting@N@
:: @@@Internet Explorer@@@

:: Enable Notifications in IE when a site attempts to install software
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer" /v SafeForScripting /t REG_DWORD /d 0 /f