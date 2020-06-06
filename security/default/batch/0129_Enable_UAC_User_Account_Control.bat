
::0129_Enable_UAC_User_Account_Control.bat
::
:: Default configuration to enforce and maintain | EnableLUA=1 !
:: 
::https://support.gfi.com/hc/en-us/articles/360012968753-How-to-disable-User-Account-Control-UAC-
::https://gallery.technet.microsoft.com/scriptcenter/Disable-UAC-using-730b6ecd
::HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 1 -Force

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system /v EnableLUA  /t REG_DWORD /d 1 /f

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system /v ConsentPromptBehaviorUser /t REG_DWORD /d 3 /f