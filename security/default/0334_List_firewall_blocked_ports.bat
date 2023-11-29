REM This batch script lists the firewall rules that are currently blocking ports on Windows 10/11. It uses the HNetCfg.FwPolicy2 COM object to access the firewall rules and PowerShell to filter and display the relevant information.

REM The script starts by creating a COM object of type HNetCfg.FwPolicy2 using the New-Object cmdlet in PowerShell. It then retrieves all the firewall rules and filters them based on the action property, selecting only the rules with an action value of 0 (which indicates blocking).

REM The selected rules are then displayed, showing the name, application name, and local ports for each rule.

REM Note: The script checks if the COM object is successfully loaded before proceeding. If the COM object fails to load, an error message is displayed and the script exits with an error code of 1.

REM Example usage: List_firewall_blocked_ports.bat
$f=New-object -comObject HNetCfg.FwPolicy2;$f.rules |  where {$_.action -eq "0"} | select name,applicationname,localports@echo off
setlocal

set "SCRIPT_PATH=%~dp0"

set "COM_OBJECT=HNetCfg.FwPolicy2"
for /f "usebackq delims=" %%I in (`powershell -Command "[System.Reflection.Assembly]::LoadWithPartialName('%COM_OBJECT%')"`) do set "COM_LOADED=%%I"
if not defined COM_LOADED (
  echo Failed to load COM object: %COM_OBJECT%
  exit /b 1
)

powershell -Command "$f=New-Object -ComObject %COM_OBJECT%; $f.Rules | Where-Object {$_.Action -eq 0} | Select-Object Name, ApplicationName, LocalPorts"

endlocal
