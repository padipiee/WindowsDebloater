echo Deleting HP Telemetry tasks 
@echo on
set spy_tasks=^
	"\Hewlett-Packard\HP Support Assistant\HP Support Solutions Framework Report"



for %%i in (%spy_tasks%) do (
	schtasks /query /tn %%i 
	if not errorlevel 1 (
		echo | set /p=%%i
		schtasks /delete /tn %%i /f 
		set item=%%i		
	)
)


REM TaskName    : \Hewlett-Packard\HP Support Assistant\HP Support Solutions Framework Report
REM Task To Run : C:\Program Files (x86)\Hewlett-Packard\HP Support Solutions\Modules\HPSFReport.exe /send