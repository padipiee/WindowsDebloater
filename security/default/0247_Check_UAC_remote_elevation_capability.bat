::REF 0239_Disable_UAC_remote_elevation_capability
::CHECK Disable UAC remote elevation capability
::This setting controls whether local accounts can be used for remote administration via network logon (e.g., NET USE, connecting to C$, etc.)

::;0131.ps1;0181.ps1;205.ps1
::https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/user-account-control-and-remote-restriction
::https://admx.help/?Category=SecurityBaseline&Policy=Microsoft.Policies.PtH::Pol_PtH_LATFP

::https://posts.specterops.io/pass-the-hash-is-dead-long-live-localaccounttokenfilterpolicy-506c25a7c167

reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy 

::Enabled (recommended): Applies UAC token-filtering to local accounts on network logons. Membership in powerful group such as Administrators is disabled and powerful privileges are removed from the resulting access token. This configures the LocalAccountTokenFilterPolicy registry value to 0. This is the default behavior for Windows.


:::::::::::::::WArning : Impacts possible for Ansible There are a few cases where LocalAccountTokenFilterPolicy needs to be set to 1 
::to enable WinRM to authenticate over NTLM. I
::REF 0084.ps1
::https://github.com/ansible/ansible/issues/42978