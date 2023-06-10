###https://www.bleepingcomputer.com/news/security/windows-11-to-require-smb-signing-to-prevent-ntlm-relay-attacks/

Set-SmbClientConfiguration -RequireSecuritySignature $true
Set-SmbServerConfiguration -RequireSecuritySignature $true