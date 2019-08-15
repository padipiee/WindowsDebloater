
REM  OneDrive Disable File Sync 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\OneDrive" /v "DisablePersonalSync" /t REG_DWORD /d 1 /f > nul
