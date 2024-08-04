::[Office ClickToRun Service Monitor] This task monitors the state of your Microsoft Office ClickToRunSvc and sends crash and error logs to Microsoft.

@Echo Off
cd %systemroot%\system32
call :IsAdmin
rem --- Disable Office ClickToRun crash and error logs to Microsoft. ---

schtasks /Change /TN "Microsoft\Office\Office ClickToRun Service Monitor" /Disable 
Pause & Exit
:IsAdmin
reg query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
Cls & Echo You must have administrator rights to continue ... 
Pause & Exit
)
Cls
goto:eof