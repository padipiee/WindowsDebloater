echo.
echo Deleting spyware/bloatware services...
set spy_services=^
	DiagTrack,dmwappushservice,diagnosticshub.standardcollector.service,DcpSvc,^
	WerSvc,PcaSvc,DoSvc,WMPNetworkSvc,XblAuthManager,XblGameSave,XboxNetApiSvc,^
	xboxgip,wlidsvc,lfsvc,NcbService,WbioSrvc,LicenseManager,OneSyncSvc,CDPSvc,^
	CDPUserSvc,MapsBroker,PhoneSvc,RetailDemo,WalletService
for %%i in (%spy_services%) do (
	sc query %%i > nul
	if not errorlevel 1060 (
		echo Current service: %%i
		sc stop %%i > nul
		sc delete %%i
		set spy_svc_found=1
	)
)
if not defined spy_svc_found (
	echo No spyware services found.
)