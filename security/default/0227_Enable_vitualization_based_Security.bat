::0227_Enable_vitualization_based_Security

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f
::https://docs.microsoft.com/en-us/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity
::https://docs.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard-manage
::https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection

:: REF 0181
:: REF 0205_CIS
:: REF 0228 RequirePlatformSecurityFeatures