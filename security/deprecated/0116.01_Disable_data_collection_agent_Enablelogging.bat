
::The following example stops logging and uploading by the agent. 
::https://docs.microsoft.com/en-us/deployoffice/compat/manage-the-privacy-of-data-monitored-by-telemetry-in-office


:: PREVENTING ??!!
::#OfficeTelemetry_PerfMetrics
::#Click-To-Run General Telemetry
::#MachineId
::#SessionID
::#Office.Telemetry.AriaEventSink.RequestMsaDeviceToken
::#Office.Telemetry.AriaEventSink.HandleMsaDeviceTokenResponse
::#Office.Telemetry.AriaEventSink.HandleMsaDeviceTokenResponse
::#Office.Telemetry.AriaEventSink.RequestMsaDeviceToken

reg query "HKCU\Software\Policies\Microsoft\Office\16.0\osm" 
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\osm" /v "Enablelogging" /t REG_DWORD /d 0 /f
