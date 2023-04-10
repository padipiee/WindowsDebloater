
::0129_Enable_UAC_User_Account_Control.bat
::
:: Default configuration to enforce and maintain | EnableLUA=1 !
:: The key is called EnableLUA because User Access Control was previously called Limited User Account (LUA).
:: 
::https://support.gfi.com/hc/en-us/articles/360012968753-How-to-disable-User-Account-Control-UAC-
::https://gallery.technet.microsoft.com/scriptcenter/Disable-UAC-using-730b6ecd
::HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 1 -Force

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system /v EnableLUA  /t REG_DWORD /d 1 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 3 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system /v ConsentPromptBehaviorUser /t REG_DWORD /d 3 /f

::
::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System ConsentPromptBehaviorAdmin DWORD
::
::0 = Elevate without prompting
::1 = Prompt for credentials on the secure desktop
::2 = Prompt for consent on the secure desktop
::3 = Prompt for credentials    <<<<<----------------------------------
::4 = Prompt for consent
::5 = Prompt for consent for non-Windows binaries (default)
