
:: The following example enables file obfuscation in the registry of a client computer.
:: https://docs.microsoft.com/en-us/deployoffice/compat/manage-the-privacy-of-data-monitored-by-telemetry-in-office
:: https://learn.microsoft.com/en-us/deployoffice/compat/manage-the-privacy-of-data-monitored-by-telemetry-in-office
:: https://admx.help/HKCU/software/policies/microsoft/office/16.0

reg query "HKCU\Software\Policies\Microsoft\Office\16.0\osm"
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\osm" /v "EnableFileObfuscation" /t REG_DWORD /d 1 /f
reg query "HKCU\Software\Policies\Microsoft\Office\16.0\osm"



