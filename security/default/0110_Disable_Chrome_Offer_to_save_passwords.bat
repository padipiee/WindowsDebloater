:: Disable_Offer_to_save_passwords_in_Google_Chrome
:: https://admx.help/?Category=ChromeOS&Policy=Google.Policies.ChromeOS::PasswordManagerEnabled

reg query "HKLM\SOFTWARE\Policies\Google\Chrome"
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v PasswordManagerEnabled /t REG_DWORD /d 0
reg add "HKLM\SOFTWARE\Policies\Google\ChromeOS" /v PasswordManagerEnabled /t REG_DWORD /d 0
reg query "HKLM\SOFTWARE\Policies\Google\Chrome"

::[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome]
::"PasswordManagerEnabled"=dword:00000000

:: PasswordManagerEnabled DWORD
:: delete = Enable (available)
:: 0 = Disable
:: 1 = Force


@REM "PasswordManagerEnabled"=dword:00000001

