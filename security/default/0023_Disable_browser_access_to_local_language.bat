::echo Disable browser access to local language 
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f 

reg add  "HKEY_USERS\.DEFAULT\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f

:::: https://www.tenforums.com/tutorials/82980-turn-off-website-access-language-list-windows-10-a.html
