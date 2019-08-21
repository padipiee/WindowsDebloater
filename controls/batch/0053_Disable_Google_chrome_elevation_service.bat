REM Keep manual and stop the suspicious GoogleChromeElevationService

REM HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService

reg add "HKLM\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" /v "Start" /t REG_DWORD /d 3 /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" /v "Type" /t REG_DWORD /d 10 /f 

REM CURRENTLY the elevation service is only installed for Google Chrome builds. THE PRIMARY USE case AT THE MOMENT for the service HAS TO DO WITH the 
REM Currently? The primary use? At the moment?