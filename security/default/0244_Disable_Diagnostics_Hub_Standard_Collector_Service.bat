::Disable_Diagnostics_Hub_Standard_Collector_Service
::REM Microsoft Diagnostics Hub Standard Collector Service
sc config diagnosticshub.standardcollector.service start=disabled

reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d 4 /f 