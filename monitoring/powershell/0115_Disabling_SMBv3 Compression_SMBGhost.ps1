
#https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/adv200005
#https://github.com/ollypwn/SMBGhost
#CVE-2020-0796 - SMBv3 RCE

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" DisableCompression -Type DWORD -Value 1 -Force