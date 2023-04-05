:: Malicious Software Removal Tool
:: Turn off Malicious Software Removal Tool telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontReportInfectionInformation /t REG_DWORD /d 1 /f
reg query "HKLM\SOFTWARE\Policies\Microsoft\MRT"