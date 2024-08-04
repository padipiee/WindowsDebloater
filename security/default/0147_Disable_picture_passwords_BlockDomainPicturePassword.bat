:: Security - Disable picture passwords BlockDomainPicturePassword.
:: https://www.tenforums.com/tutorials/80575-disable-domain-users-sign-picture-password-windows-10-a.html

::0 or (delete) = Enable
:: 1 = Disable
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "BlockDomainPicturePassword" /t REG_DWORD /d 1 /f
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System"