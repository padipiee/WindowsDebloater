
@echo off
setlocal EnableDelayedExpansion


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
	"Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"	
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

