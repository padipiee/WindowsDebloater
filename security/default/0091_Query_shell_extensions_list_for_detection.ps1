<#
.SYNOPSIS
Queries the shell extensions list for detection.

.DESCRIPTION
This script checks if the registry key "HKCU:\Software\Microsoft\Windows\CurrentVersion\Shell Extensions" exists and if so, it retrieves the values using the "reg query" command.

.PARAMETER None

.EXAMPLE
.\0091_Query_shell_extensions_list_for_detection.ps1
#>
write-host "[0091_Query_shell_extensions_list_for_detection] Querying the shell extensions list for detection..."
if (Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Shell Extensions") {
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Shell Extensions"
}


# ::Query Shell Extensions list for detection of malicious ones
# :: reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions"
# :: default empy folder with 1 key --> HasFlushedShellExtCache    REG_DWORD    0x1
# :: Example used by Win32/StealthFalcon Ref https://www.welivesecurity.com/2019/09/09/backdoor-stealth-falcon-group/
    
