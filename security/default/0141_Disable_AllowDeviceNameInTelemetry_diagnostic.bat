
:: Disable device names in Windows Analytics with Intune
:: https://www.vroege.biz/?p=4084
:: https://osddeployment.dk/2018/07/19/how-to-get-windows-10-1803-device-names-in-windows-analytics-with-intune/
:: HKLM\Software\Microsoft\Windows\DataCollection\AllowDeviceNameInTelemetry
:: https://getadmx.com/?Category=Windows_10_2016&Policy=Microsoft.Policies.DataCollection::AllowDeviceNameInDiagnosticData


::This policy allows the device name to be sent to Microsoft as part of Windows diagnostic data.
::If you disable or do not configure this policy setting, then device name will not be sent to Microsoft as part of Windows diagnostic data.

reg add "HKLM\Software\Microsoft\Windows\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d 0 /f 