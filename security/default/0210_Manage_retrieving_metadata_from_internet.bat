:: Privacy - Disable/Manage device metadata retrieval from the Internet.
:: https://www.top-password.com/blog/change-device-installation-settings-in-windows/
::https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.DeviceSoftwareSetup::DeviceMetadata_PreventDeviceMetadataFromNetwork


::This policy setting allows you to prevent Windows from retrieving device metadata from the Internet.

::If you enable this policy setting, Windows does not retrieve device metadata for installed devices from the Internet. 
::This policy setting overrides the setting in the Device Installation Settings dialog box 
:: (Control Panel > System and Security > System > Advanced System Settings > Hardware tab).

::If you disable or do not configure this policy setting, the setting in the Device Installation Settings dialog box controls whether Windows retrieves device :: metadata from the Internet.

:: Security TRADE-OFF !!
:: Enabled Value	1
:: Disabled Value	0
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 0 /f

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata"