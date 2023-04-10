:: Force Clear Browsing Data on Close in Microsoft Edge for All Users
:: https://www.tenforums.com/tutorials/153307-turn-off-clear-browsing-data-close-microsoft-edge-chromium.html
:: https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v ClearBrowsingDataOnExit  /t REG_DWORD /d 1 /f
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge"





