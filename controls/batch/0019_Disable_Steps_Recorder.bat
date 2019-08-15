REM Disable Steps Recorder 

REM Steps Recorder (called Problems Steps Recorder in Windows , is a program that helps you troubleshoot 
REM a problem on your device by recording the exact steps you took when the problem occurred

echo Disable Steps Recorder 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f 
