:: Disable saving passwords to the password manager
:: https://admx.help/?Category=EdgeChromium&Policy=Microsoft.Policies.Edge::PasswordManagerEnabled_recommended

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PasswordManagerEnabled  /t REG_DWORD /d 0 /f
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge"





