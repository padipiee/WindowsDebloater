<<<<<<< HEAD
:: Disables SMB Compression from being used when client connect to this server. Note outbound clients from this machine may still use compression.
=======
>>>>>>> feae34e98302c12b3753da7b45b8072fcab3dc01
:: Workarround for CoronaBlue/SMBGhost Worm exploiting CVE-2020-0796
:: https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV200005
:: Active Directory Administrative Templates
:: https://github.com/technion/DisableSMBCompression
:: Disable SMBv3 compression
:: #https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/adv200005
:: #https://github.com/ollypwn/SMBGhost
:: #CVE-2020-0796 - SMBv3 RCE

:: Ref 0115_Disabling_SMBv3 Compression_SMBGhost.ps1
:: https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2020-0796
:: Disable SMBv3 compression. You can disable compression to block unauthenticated attackers from exploiting the vulnerability against an SMBv3 Server 
:: https://admx.help/?Category=DisableSMBCompression&Policy=Microsoft.Policies.SMBCompression::Pol_SMB_DisableCompression

reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "DisableCompression" /t REG_DWORD /d 1 /f
:: Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" DisableCompression -Type DWORD -Value 1 -Force


:: :: powershell.exe Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" DisableCompression -Type DWORD -Value 1 -Force
:: You can disable the workaround with the PowerShell command below.
:: powershell.exe Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" DisableCompression -Type DWORD -Value 0 -Force