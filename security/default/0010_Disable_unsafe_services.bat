
:: Disable unsafe services...
set unsafe_services=^
	RemoteRegistry,TermService,TrkWks,DPS,^
	SensorDataService,SensorService,SensrSvc
for %%i in (%unsafe_services%) do (
	echo Current service: %%i
	sc stop %%i > nul
	sc config %%i start= disabled
)


:: Privacy - Stop unneeded services.
net stop DiagTrack
net stop dmwappushservice
net stop RemoteRegistry
net stop RetailDemo
net stop WinRM
net stop WMPNetworkSvc

:: Privacy - Delete, or disable, unneeded services.
sc config RemoteRegistry start=disabled
sc config RetailDemo start=disabled
sc config WinRM start=disabled
sc config WMPNetworkSvc start=disabled
sc delete DiagTrack
sc delete dmwappushservice