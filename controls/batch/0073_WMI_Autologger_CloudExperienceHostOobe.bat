Echo Disable WMI_Autologger_CloudExperienceHostOobe

reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\CloudExperienceHostOobe" /v "Start" /t REG_DWORD /d 0 /f

REM REF  https://www.anoopcnair.com/mdm-diagnostics-tool-windows-autopilot/
REM  Where is the location of CloudExperienceHost? It is part of system apps within c:\windows\systemapps folder 
REM In Windows Autopilot deployment, CloudExperienceHost process communicates with Azure. 
REM To trace CloudExperienceHost process activity, MDM Diagnostics Tool generates Event Tracing Logs (this is called ETW – Event Tracing for Windows)