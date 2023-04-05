:: Disable with Policy AppPrivacy

@REM #   Phone calls
@REM #     Let Windows apps make phone calls => Disabled
@REM #       Group Policy > Computer Configuration\Administrative Templates\Windows Components\App Privacy\Let Windows apps make phone calls => Disabled

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone" /t REG_DWORD /d 2 /f
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"