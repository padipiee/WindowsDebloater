echo Disable OneSync Sync Host service
REM This service synchronizes mail, contacts, calendar and various other user data. 
REM Mail and other applications dependent on this functionality will not work properly when this service is not running.
REM HKEY_LOCAL_MACHINE
reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_8b42a" /v "Start" /t REG_DWORD /d 4 /f 