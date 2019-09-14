::Query Shell Extensions list for detection of malicious ones
:: reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions"
:: default empy folder with 1 key --> HasFlushedShellExtCache    REG_DWORD    0x1
:: Example used by Win32/StealthFalcon Ref https://www.welivesecurity.com/2019/09/09/backdoor-stealth-falcon-group/

reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions"
    
