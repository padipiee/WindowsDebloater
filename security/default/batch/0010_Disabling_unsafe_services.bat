
echo.
echo Disabling unsafe services...
set unsafe_services=^
	RemoteRegistry,TermService,TrkWks,DPS,^
	SensorDataService,SensorService,SensrSvc
for %%i in (%unsafe_services%) do (
	echo Current service: %%i
	sc stop %%i > nul
	sc config %%i start= disabled
)