

::After you install this security update, you can control how installed WDigest credentials can be saved by using a registry setting. To prevent WDigest credentials from being stored in memory, a Group Policy setting can be applied to the UseLogonCredential registry entry under the following subkey:
:: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\WDigest
:: If the UseLogonCredential value is set to 0, WDigest will not store credentials in memory.
:: https://support.microsoft.com/en-us/help/2871997/microsoft-security-advisory-update-to-improve-credentials-protection-a

::Digest Authentication is a challenge/response protocol that was primarily used in Windows Server 2003 for LDAP and web-based authentication. 
::It utilizes Hypertext Transfer Protocol (HTTP) and Simple Authentication Security Layer (SASL) exchanges to authenticate.
:: https://blog.stealthbits.com/wdigest-clear-text-passwords-stealing-more-than-a-hash/

::https://www.stigviewer.com/stig/windows_7/2016-12-19/finding/V-72753

reg add HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential /t REG_DWORD /d 0 /f
reg query HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential