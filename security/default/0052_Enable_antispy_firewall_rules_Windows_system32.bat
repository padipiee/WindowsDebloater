
@echo off
setlocal EnableDelayedExpansion

set spy_apps=^
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
	"Windows\System32\WWAHost.exe"
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

