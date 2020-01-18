
Get-WinEvent -LogName application | where {$_.Id -eq 1}

#https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2020-0601

#How can I tell is someone is attempting to use a forged certificate to exploit this vulnerability?
#ProviderName: Microsoft-Windows-Audit-CVE
#
#TimeCreated                     Id LevelDisplayName Message
#-----------                     -- ---------------- -------
#2020-01-18 10:39:26 AM           1 Warning          Possible detection of CVE: [CVE-2020-0601] cert validation...