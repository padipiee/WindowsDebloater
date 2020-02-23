
:: Deleting Microsoft Compatibility Appraiser scheduled task
:: This is deleting Telemetry task activated despite you deactivate Telemetry from Settings...
:: %windir%\system32\compattelrunner.exe

echo Deleting Microsoft Compatibility Appraiser scheduled task
set spy_tasks="Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"

for %%i in (%spy_tasks%) do (
	schtasks /query /tn %%i 
	if not errorlevel 1 (
		echo | set /p=%%i
		schtasks /delete /tn %%i /f 
	)
)