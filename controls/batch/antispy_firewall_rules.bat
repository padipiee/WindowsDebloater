
@echo off
setlocal EnableDelayedExpansion

ver | find "10." > nul
if errorlevel 1 (
	echo Your Windows version is not Windows 10...exiting...
	pause
	exit
) else (
	echo Your Windows version is   Windows 10! Lets proceed.
)


echo.
echo Adding antispy firewall rules...
set spy_ips=^
	104.96.147.3,111.221.29.177,111.221.29.253,111.221.64.0-111.221.127.255,^
	131.253.40.37,134.170.115.60,134.170.165.248,134.170.185.70,131.253.40.109,^
	134.170.30.202,137.116.81.24,137.117.235.16,157.55.129.21,198.78.208.254,^
	157.55.130.0-157.55.130.255,157.55.235.0-157.55.235.255,66.119.144.189,^
	157.55.236.0-157.55.236.255,157.55.52.0-157.55.52.255,134.170.51.248,^
	157.55.56.0-157.55.56.255,157.56.106.189,157.56.121.89,157.56.124.87,^
	157.56.91.77,168.63.108.233,191.232.139.2-191.232.139.255,131.253.40.53,^
	191.232.80.62,191.237.208.126,195.138.255.0-195.138.255.255,94.245.121.251,^
	2.22.61.43,2.22.61.66,204.79.197.200,207.46.101.29,207.46.114.58,207.46.223.94,^
	207.68.166.254,212.30.134.204,212.30.134.205,213.199.179.0-213.199.179.255,^
	23.102.21.4,23.218.212.69,23.223.20.82,23.57.101.163,23.57.107.163,^
	23.57.107.27,23.99.10.11,64.4.23.0-64.4.23.255,64.4.54.22,64.4.54.32,^
	64.4.6.100,65.39.117.230,65.52.100.11,65.52.100.7,65.52.100.9,65.52.100.91,^
	65.52.100.92,65.52.100.93,65.52.100.94,65.52.108.29,65.52.108.33,65.55.108.23,^
	65.55.138.186,65.55.223.0-65.55.223.255,157.56.106.184,131.253.40.59,^
	65.55.252.63,65.55.252.71,65.55.252.92,65.55.252.93,65.55.29.238,65.55.39.10,^
	77.67.29.176,204.79.197.203,111.221.29.254,128.63.2.53,131.253.14.153,^
	134.170.188.248,134.170.52.151,157.56.149.250,207.46.114.61,64.4.54.153,^
	157.56.57.5,157.56.74.250,168.61.24.141,168.62.187.13,191.232.140.76,^
	64.4.54.253,64.4.54.254,65.52.108.153,65.52.108.154,65.55.44.108,65.52.161.64,^
	65.55.130.50,65.55.138.110,65.55.176.90,65.55.252.43,65.55.44.109,^
	65.55.83.120,66.119.147.131,194.44.4.200,194.44.4.208,8.254.209.254,^
	157.56.77.139,134.170.58.121,207.46.194.14,207.46.194.33,13.107.3.128,^
	134.170.53.30,134.170.51.190,131.107.113.238,157.56.96.58,23.67.60.73,^
	104.82.22.249,207.46.194.25,173.194.113.220,173.194.113.219,216.58.209.166,^
	157.56.91.82,157.56.23.91,104.82.14.146,207.123.56.252,185.13.160.61,^
	94.245.121.253,65.52.108.92,207.46.7.252,23.74.8.99,23.74.8.80,65.52.108.103,^
	23.9.123.27,23.74.9.198,23.74.9.217,23.96.212.225,23.101.115.193,^
	23.101.156.198,23.101.187.68,23.102.17.214,23.193.225.197,23.193.230.88,^
	23.193.236.70,23.193.238.90,23.193.251.132,23.210.5.16,23.210.48.42,^
	23.210.63.75,23.217.138.11,23.217.138.18,23.217.138.25,23.217.138.43,^
	23.217.138.90,23.217.138.97,23.217.138.122,40.117.145.132,65.52.108.94,^
	65.52.108.252,65.52.236.160,65.55.113.13,65.55.252.190,65.52.108.27,^
	94.245.121.254,104.73.92.149,104.73.138.217,104.73.143.160,104.73.153.9,^
	104.73.160.16,104.73.160.51,104.73.160.58,104.91.166.82,104.91.188.21,^
	104.208.28.54,134.170.51.246,134.170.179.87,137.116.74.190,157.56.77.138,^
	157.56.96.123,157.56.144.215,157.56.144.216,198.41.214.183,198.41.214.184,^
	198.41.214.186,198.41.214.187,198.41.215.182,198.41.215.185,198.41.215.186
for %%i in (%spy_ips%) do (
	netsh advfirewall firewall show rule %%i_BLOCK > nul
		if errorlevel 1 (
			echo | set /p=%%i_BLOCK 
			route -p ADD %%i MASK 255.255.255.255 0.0.0.0 > nul 2>&1
			netsh advfirewall firewall add rule name="%%i_BLOCK" dir=out interface=any action=block remoteip=%%i > nul
			set frw_rule_added=1
			echo [OK]
		)
)
set svchost=%SystemRoot%\System32\svchost.exe
set svchost_rules=^
	"VeriSign Global Registry Services;199.7.48.0-199.7.63.255,199.16.80.0-199.16.95.255"^
	"Microsoft Limited;94.245.64.0-94.245.127.255"^
	"Microsoft Internet Data Center;213.199.160.0-213.199.191.255"^
	"Akamai Technologies;92.122.212.0-92.122.219.255,92.123.96.0-92.123.111.255,95.100.0.0-95.100.15.255,23.32.0.0-23.67.255.255"
for %%i in (%svchost_rules%) do (
	for /f "tokens=1,2 delims=;" %%a in (%%i) do (
		netsh advfirewall firewall show rule "%%a SVCHOST_BLOCK" > nul
		if errorlevel 1 (
			echo | set /p=%%a SVCHOST_BLOCK 
			netsh advfirewall firewall add rule name="%%a SVCHOST_BLOCK" dir=out interface=any action=block program=%svchost% remoteip=%%b > nul
			set frw_rule_added=1
			echo [OK]
		)
	)
)
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

