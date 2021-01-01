

:: @N@ Disable Office 16  @N@
 
reg add "HKCU\SOFTWARE\Policies\Microsoft\office\16.0\common\privacy" /v "usercontentdisabled" /t REG_DWORD /d 2 /f


:: This is equivalent to configuring the policy settings User Configuration\Administrative Templates\Microsoft Office 2016\Privacy\Trust Center\Enable Customer Experience Improvement Program and User
:: Configuration\Administrative Templates\Microsoft Office 2016\Privacy\Trust
:: Center\Send personal information to Disabled.
:: REF : https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/Studien/Office_Telemetrie/Office_Telemetrie.pdf?__blob=publicationFile&v=5
:: page 28 Disabling the output of diagnostic data


::[HKEY_CURRENT_USER\Software\Policies\Microsoft\office\16.0\common\privacy]
::"usercontentdisabled"=dword:00000002
::"downloadcontentdisabled"=dword:00000002
::"controllerconnectedservicesenabled"=dword:00000002


