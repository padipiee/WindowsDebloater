<#
.SYNOPSIS
Enables SMB signing on the client and server to ensure secure communication.

.DESCRIPTION
This script enables SMB signing on the client and server to ensure secure communication. 
SMB signing is a security mechanism in Windows that helps prevent man-in-the-middle attacks 
and ensures the authenticity of SMB packets.
###https://www.bleepingcomputer.com/news/security/windows-11-to-require-smb-signing-to-prevent-ntlm-relay-attacks/

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
./0343_windows-11-require-smb-signing.ps1
Enables SMB signing on the client and server.

.NOTES
Author: 
Date:   DD/MM/YYYY
#>

Set-SmbClientConfiguration -RequireSecuritySignature $true
Set-SmbServerConfiguration -RequireSecuritySignature $true