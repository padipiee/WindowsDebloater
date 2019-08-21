
@echo off
setlocal EnableDelayedExpansion


set spy_apps=^
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

