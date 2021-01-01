

:: @N@ Disable Customer Experience Improvement Program @N@
:: Refer to 0119_DisableOfficeTelemetry.reg for more details
:: https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_EnableCustomerExperienceImprovementProgram


reg add "HKCU\SOFTWARE\Policies\Microsoft\office\16.0\common" /v "qmenable" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\office\16.0\common" /v "sendcustomerdata" /t REG_DWORD /d 0 /f


:: This is equivalent to configuring the policy settings User Configuration\Administrative Templates\Microsoft Office 2016\Privacy\Trust Center\Enable Customer Experience Improvement Program and User
:: Configuration\Administrative Templates\Microsoft Office 2016\Privacy\Trust
:: Center\Send personal information to Disabled.
:: REF : https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/Studien/Office_Telemetrie/Office_Telemetrie.pdf?__blob=publicationFile&v=5



:: https://forum.uifserver.net/index.php?topic=145283.0

