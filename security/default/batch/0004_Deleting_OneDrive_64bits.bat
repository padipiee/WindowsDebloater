:: Deleting OneDrive 64 bits


if exist %SystemRoot%\SysWOW64\OneDriveSetup.exe (
	start /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	echo | set /p=0004 - Deleting OneDrive 64bits... 
	taskkill /f /im OneDrive.exe > nul 2>&1
	rd "%UserProfile%\OneDrive" /q /s > nul 2>&1
	rd "%SystemDrive%\OneDriveTemp" /q /s > nul 2>&1
	rd "%LocalAppData%\Microsoft\OneDrive" /q /s > nul 2>&1
	rd "%ProgramData%\Microsoft OneDrive" /q /s > nul 2>&1
) 
