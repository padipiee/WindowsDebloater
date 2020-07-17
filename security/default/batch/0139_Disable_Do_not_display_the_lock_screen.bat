echo | set /p=Disable "Disable_Do_not_display_the_lock_screen"
:: https://getadmx.com/?Category=Windows_10_2016&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_NoLockScreen
::Registry Hive	HKEY_LOCAL_MACHINE
::Registry Path	Software\Policies\Microsoft\Windows\Personalization
::Value Name	NoLockScreen
::Value Type	REG_DWORD
::Enabled Value	1
::Disabled Value	0

::If you disable or do not configure this policy setting, users that are not required to press CTRL + ALT + DEL before signing in will see a lock screen after locking their PC

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 0 /f 