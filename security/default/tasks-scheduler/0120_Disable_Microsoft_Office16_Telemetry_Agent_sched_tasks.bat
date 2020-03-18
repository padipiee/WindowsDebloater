

::[OfficeTelemetryAgentFallBack2016] This task initiates the background task for Office Telemetry Agent, which scans and uploads usage and error information for Office solutions.

::[OfficeTelemetryAgentLogOn2016] This task initiates Office Telemetry Agent, which scans and uploads usage and error information for Office solutions when a user logs on to the computer.

@Echo Off
cd %systemroot%\system32
call :IsAdmin
rem --- Disable Office Telemetry ---
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable
Pause & Exit
:IsAdmin
reg query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
Cls & Echo You must have administrator rights to continue ... 
Pause & Exit
)
Cls
goto:eof