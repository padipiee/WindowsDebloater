reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsBackup" /v "DisableMonitoring" /t REG_DWORD /d 1 /f


::Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsBackup     Value: DisableMonitoring    
::Type: REG_DWORD 
::Data Enabled: 0 (or not exist) = Disabled    
::Data Disabled: 1 = Enabled

:: https://social.technet.microsoft.com/wiki/contents/articles/2347.group-policy-how-to-turn-off-the-set-up-backup-message-in-action-center-centre.aspx