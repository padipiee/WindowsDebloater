# Refer to  0197_Enable_Structured_Exception_Handling_Overwrite_Protection_Exception_chains_SEHOP.ps1

# https://www.stigviewer.com/stig/windows_10/2019-01-04/finding/V-68849
# https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/override-mitigation-options-for-app-related-security-policies

Get-ProcessMitigation -System | Select-Object -ExpandProperty SEHOP
Set-ProcessMitigation -System -Enable SEHOP
Get-ProcessMitigation -System | Select-Object -ExpandProperty SEHOP


