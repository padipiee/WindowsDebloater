
:: Configure_Windows_Defender_SmartScreen
:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.MicrosoftEdge::AllowSmartScreen
:: https://admx.help/HKCU/Software/Policies/Microsoft/MicrosoftEdge/PhishingFilter

::  Windows Defender SmartScreen provides warning messages 
::If you enable this setting, Windows Defender SmartScreen is turned on and employees can't turn it off.
::If you disable this setting, Windows Defender SmartScreen is turned off and employees can't turn it on.
::If you don't configure this setting, employees can choose whether to use Windows Defender SmartScreen.
reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 1 /f


reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 1 /f


reg query "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter"
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "1" /f