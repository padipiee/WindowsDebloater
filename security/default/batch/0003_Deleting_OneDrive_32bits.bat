REM Deleting OneDrive 32 bits

if exist %SystemRoot%\System32\OneDriveSetup.exe (
	start /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
	echo | set /p=0003 - Deleting OneDrive 32bits... 
	taskkill /f /im OneDrive.exe > nul 2>&1
	rd "%UserProfile%\OneDrive" /q /s > nul 2>&1
	rd "%SystemDrive%\OneDriveTemp" /q /s > nul 2>&1
	rd "%LocalAppData%\Microsoft\OneDrive" /q /s > nul 2>&1
	rd "%ProgramData%\Microsoft OneDrive" /q /s > nul 2>&1
) 