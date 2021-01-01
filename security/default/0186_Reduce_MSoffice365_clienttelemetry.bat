::Reduce_Office365_Telemetry
:: Disables the two Office Telemetry modules (disables the Aria and Nexus Office telemetry modules) and reduces the amount of info sent to Microsoft.
::  For example, if DisableTelemetry is set to 1, Office applications do not load the MSOARIANEXT.dll library file, which implements Aria

reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\office\common\clienttelemetry" /v "DisableTelemetry" /t REG_DWORD /d "1" /f

::HKEY_CURRENT_USER\Software\Policies\Microsoft\office\common\clienttelemetry DisableTelemetry

::https://office-watch.com/2020/how-to-reduce-microsofts-spying-on-your-office-use/
:: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/Studien/Office_Telemetrie/Office_Telemetrie.pdf?__blob=publicationFile&v=5
:: Configuring the diagnostic data level required, optional, or neither results in setting the registry value 
::HKEY_CURRENT_USER\Software\Policies\Microsoft\office\common\clienttelemetry\sendtelemetry to 1, 2, and 3, respectively. 


:: HKEY_CURRENT_USER\Software\Policies\Microsoft\office\common\clienttelemetry\EnableWriteTelemetryEventsToNexus is set to 1, Office applications do not use Aria, but the telemetry module referred to as Nexus

::Ensure C:\Windows\System32\drivers\etc\hosts redirect NExus sites to 0.0.0.0
::0.0.0.0 nexus.officeapps.live.com
::0.0.0.0 nexusrules.officeapps.live.com

