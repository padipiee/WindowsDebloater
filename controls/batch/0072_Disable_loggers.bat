echo Disable loggers 

REM C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\ If you can see AutoLogger-Diagtrack-Listener.etl in there,
REM # then Microsoft has ignored your wishes to opt out of the CEIP (assuming you did) and continues to monitor everything you do on the machine.
REM #The registry key which controls it is this one: HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener\
REM #To call a halt to its antics, click AutoLogger-Diagtrack-Listener and then in the right hand pane right click Start and click Modify.
REM # Change the 1 into 0 and click OK.
REM Next, scroll down to {DD17FA14-CDA6-7191-9B61-37A28F7A10DA} and in the right hand pane right click Enabled and click Modify.
REM Change the figure 1 into a 0  as well. Click OK and then reboot the machine.
REM #Ref %systemroot%\System32\LogFiles\WMI\AutoLogger-Diagtrack-Listener.etl

reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
