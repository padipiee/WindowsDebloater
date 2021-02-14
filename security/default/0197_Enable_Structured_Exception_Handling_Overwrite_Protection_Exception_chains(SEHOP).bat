::Enable_Structured_Exception_Handling_Overwrite_Protection_(SEHOP).bat

:: Windows Security >> App & Browser control >> Exploit protection settings >> Validate exeception chains
:: Ensures the integrity of an exception chain during dispatch

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"  /v DisableExceptionChainValidation /t REG_DWORD /d 0 /f 

::Value Name: DisableExceptionChainValidation
::Value Type: REG_DWORD
::Value: 0
:: https://www.ghacks.net/2012/07/16/advanced-windows-security-activating-sehop/
:: https://www.stigviewer.com/stig/windows_8_8.1/2016-06-08/finding/V-68847