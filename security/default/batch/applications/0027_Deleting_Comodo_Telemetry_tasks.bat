echo Deleting Comodo Telemetry tasks 
@echo off
set spy_tasks=^
	"\COMODO\COMODO Telemetry {18AD3DFA-30C0-4B5F-84F7-F1870B1A4921}"

for %%i in (%spy_tasks%) do (
	schtasks /query /tn %%i 
	if not errorlevel 1 (
		echo | set /p=%%i
		schtasks /delete /tn %%i /f 
		set item=%%i		
	)
)

REM <Author>COMODO Security Solutions Inc.</Author>
REM <URI>\COMODO\COMODO Telemetry {18AD3DFA-30C0-4B5F-84F7-F1870B1A4921}</URI>
REM C:\Program Files\COMODO\COMODO Internet Security\cis.exe --telemetry"
REM set tasks_dir=C:\Program Files\COMODO\COMODO Internet Security\cis.exe"
REM set dir_path="%tasks_dir%\!item:~1!
REM mkdir !dir_path!
REM icacls !dir_path! /deny "Everyone:(OI)(CI)W" > nul
REM set spy_task_deleted=1