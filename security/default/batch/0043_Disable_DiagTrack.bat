echo  Disable DiagTrack

REM  !!!  ADMIN Priv required !!! 

REM Service name DiagTrack
REM  C:\WINDOWS\System32\svchost.exe -k utcsvc -p
REM The Connected User Experiences and Telemetry service enables features 
REM that support in-application and connected user experiences. 
REM Additionally, this service manages the event driven collection and transmission of diagnostic
REM and usage information (used to improve the experience and quality of the Windows Platform)
REM when the diagnostics and usage privacy option settings are enabled under Feedback and Diagnostics.

reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f 

REM SERVICE_NAME: DiagTrack TYPE : 10  WIN32_OWN_PROCESS
REM Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f 