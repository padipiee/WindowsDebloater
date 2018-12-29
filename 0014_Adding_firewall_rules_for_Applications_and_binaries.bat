REM Adding firewall rules for Applications and binaries
REM To enable or disable according to needs and usage

set spy_apps=^
	"Program Files\Common Files\microsoft shared\OFFICE16\OLicenseHeartbeat.exe"^
	"Program Files\Microsoft Office\Office16\EXCEL.EXE"^
	"Program Files\Microsoft Office\Office16\MSACCESS.EXE"^
	"Program Files\Microsoft Office\Office16\msoia.exe"^
	"Program Files\Microsoft Office\Office16\MSOSYNC.EXE"^
	"Program Files\Microsoft Office\Office16\MSOUC.EXE"^
	"Program Files\Microsoft Office\Office16\MSPUB.EXE"^
	"Program Files\Microsoft Office\Office16\POWERPNT.EXE"^
	"Program Files\Microsoft Office\Office16\SETLANG.EXE"^
	"Program Files\Microsoft Office\Office16\WINWORD.EXE"^
	"Program Files\Microsoft Office\root\Office16\EXCEL.EXE"^
	"Program Files\Microsoft Office\root\Office16\MSACCESS.EXE"^
	"Program Files\Microsoft Office\root\Office16\msoia.exe"^
	"Program Files\Microsoft Office\root\Office16\MSOSYNC.EXE"^
	"Program Files\Microsoft Office\root\Office16\MSOUC.EXE"^
	"Program Files\Microsoft Office\root\Office16\MSPUB.EXE"^
	"Program Files\Microsoft Office\root\Office16\POWERPNT.EXE"^
	"Program Files\Microsoft Office\root\Office16\SETLANG.EXE"^
	"Program Files\Microsoft Office\root\Office16\WINWORD.EXE"^
	"Program Files (x86)\Common Files\Microsoft Shared\OFFICE16\OLicenseHeartbeat.exe"^
	"Program Files (x86)\Microsoft Office\Office16\EXCEL.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\MSACCESS.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\msoia.exe"^
	"Program Files (x86)\Microsoft Office\Office16\MSOSYNC.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\MSOUC.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\MSPUB.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\POWERPNT.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\SETLANG.EXE"^
	"Program Files (x86)\Microsoft Office\Office16\WINWORD.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\msoia.exe"^
	"Program Files (x86)\Microsoft Office\root\Office16\MSOSYNC.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\MSOUC.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\MSPUB.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\SETLANG.EXE"^
	"Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"^
	"Windows\explorer.exe"^
	"Windows\ImmersiveControlPanel\SystemSettings.exe"^
	"Windows\System32\backgroundTaskHost.exe"^
	"Windows\System32\BackgroundTransferHost.exe"^
	"Windows\System32\browser_broker.exe"^
	"Windows\System32\CompatTelRunner.exe"^
	"Windows\System32\dmclient.exe"^
	"Windows\System32\InstallAgentUserBroker.exe"^
	"Windows\System32\lsass.exe"^
	"Windows\System32\msfeedssync.exe"^
	"Windows\System32\rundll32.exe"^
	"Windows\System32\SettingSyncHost.exe"^
	"Windows\System32\SIHClient.exe"^
	"Windows\System32\smartscreen.exe"^
	"Windows\System32\taskhostw.exe"^
	"Windows\System32\wbem\WmiPrvSE.exe"^
	"Windows\System32\WerFault.exe"^
	"Windows\System32\wermgr.exe"^
	"Windows\System32\wsqmcons.exe"^
	"Windows\System32\WWAHost.exe"^
	"Windows\SystemApps\ContactSupport_cw5n1h2txyewy\ContactSupport.exe"^
	"Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe"^
	"Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe"^
	"Windows\SysWOW64\backgroundTaskHost.exe"^
	"Windows\SysWOW64\BackgroundTransferHost.exe"^
	"Windows\SysWOW64\InstallAgentUserBroker.exe"^
	"Windows\SysWOW64\msfeedssync.exe"^
	"Windows\SysWOW64\rundll32.exe"^
	"Windows\SysWOW64\SettingSyncHost.exe"^
	"Windows\SysWOW64\wbem\WmiPrvSE.exe"^
	"Windows\SysWOW64\WerFault.exe"^
	"Windows\SysWOW64\wermgr.exe"^
	"Windows\SysWOW64\WWAHost.exe"
for %%i in (%spy_apps%) do (
	set item=%%i
	set file_path="%SystemDrive%\!item:~1!
	if exist !file_path! (
		echo !file_path! | find "SysWOW64" > nul
		if errorlevel 1 (
			set rule_name=%%~nxi_BLOCK
		) else (
			set rule_name=%%~nxi-SysWOW64_BLOCK
		)
		netsh advfirewall firewall show rule !rule_name! > nul
		if errorlevel 1 (
			echo | set /p=!rule_name! 
			netsh advfirewall firewall add rule name=!rule_name! dir=out interface=any action=block program=!file_path! > nul
			set frw_rule_added=1
			echo [OK]
		)
	)
)
set spy_svc=WSearch
netsh advfirewall firewall show rule %spy_svc%_BLOCK > nul
if errorlevel 1 (
	echo | set /p=%spy_svc%_BLOCK 
	netsh advfirewall firewall add rule name="%spy_svc%_BLOCK" dir=out interface=any action=block service=%spy_svc% > nul
	set frw_rule_added=1
	echo [OK]
)
if not defined frw_rule_added (
	echo Antispy rules already present.
)