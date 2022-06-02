::Disable UAC remote elevation capability

::;0131.ps1;0181.ps1;205.ps1
::https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/user-account-control-and-remote-restriction
::https://admx.help/?Category=SecurityBaseline&Policy=Microsoft.Policies.PtH::Pol_PtH_LATFP
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_dword /d 0

::Enabled (recommended): Applies UAC token-filtering to local accounts on network logons. Membership in powerful group such as Administrators is disabled and powerful privileges are removed from the resulting access token. This configures the LocalAccountTokenFilterPolicy registry value to 0. This is the default behavior for Windows.


:::::::::::::::WArning : Impacts possible for Ansible There are a few cases where LocalAccountTokenFilterPolicy needs to be set to 1 
::to enable WinRM to authenticate over NTLM. I
::REF 0084.ps1
::https://github.com/ansible/ansible/issues/42978