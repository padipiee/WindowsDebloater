
::The following example enables file obfuscation in the registry of a client computer.
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\osm" /v "EnableFileObfuscation" /t REG_DWORD /d 1 /f
::https://docs.microsoft.com/en-us/deployoffice/compat/manage-the-privacy-of-data-monitored-by-telemetry-in-office


