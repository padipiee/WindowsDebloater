:: Deleting trash apps

reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "ProductName" | find "LTSB" > nul
if not errorlevel 1 (
	set LTSB=1
)

if not defined LTSB (
	cls
	echo 0001 - Deleting trash apps...
	powershell -Command "& {Get-AppxPackage -AllUsers | Remove-AppxPackage; Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online;}"
	takeown /f "%ProgramFiles%\WindowsApps" /r
	icacls "%ProgramFiles%\WindowsApps" /inheritance:e /grant "%UserName%:(OI)(CI)F" /T /C
	for /d %%i in ("%ProgramFiles%\WindowsApps\*") do (
		rd /s /q "%%i"
	)
	icacls "%ProgramFiles%\WindowsApps" /setowner "NT Service\TrustedInstaller"
	icacls "%ProgramFiles%\WindowsApps" /inheritance:r /remove "%UserName%"
)