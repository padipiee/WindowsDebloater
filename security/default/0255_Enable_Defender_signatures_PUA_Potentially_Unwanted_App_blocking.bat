::ref 0166
::##!!trade-off!!


:: Enable Defender signatures for Potentially Unwanted Applications (PUA)
powershell.exe Set-MpPreference -PUAProtection enable

:: ref1 https://learn.microsoft.com/en-us/answers/questions/149923/gpo-to-turn-on-reputation-based-protection-windows.html


::There is a new setting introduced with Windows Server 2022 for "Block downloads".
::
::The GPO setting to control that is:
::Windows Components/Microsoft Edge/SmartScreen settings
::- Configure Microsoft Defender SmartScreen to block potentially unwanted apps: Enabled
::
::App & browser control will then show as fully turned on.
::
::
::In summary, the PUA GPO settings are as follows:
::
::For Windows Server 2016:
::MS Security Guide
::- Turn on Windows Defender protection against Potentially Unwanted Applications
::
::For Windows Server 2019:
::Windows Components/Microsoft Defender Antivirus
::- Configure detection for potentially unwanted applications: Enabled = Block
::
::For Windows Server 2022
::Windows Components/Microsoft Edge/SmartScreen settings
::- Configure Microsoft Defender SmartScreen to block potentially unwanted apps: Enabled

::::::
::ref 2 : https://www.bleepingcomputer.com/news/security/exploited-windows-zero-day-lets-javascript-files-bypass-security-warnings/


::This issue is in the new-as-of-Win10 SmartScreen feature. 
:: And disabling "Check apps and files" reverts Windows to the legacy behavior, where MotW prompts are unrelated to Authenticode 
:: signatures," Dormann told BleepingComputer.
::"So that whole setting is unfortunately currently a tradeoff.  
:: On one hand, it does scan for baddies that are downloaded."
::"On the other, baddies that take advantage of this bug can get a LESS-SECURE behavior 
::from Windows compared to when the feature is disabled."

:: Ref 3 https://twitter.com/wdormann/status/1583311677415510017

:: ref 4 https://www.bleepingcomputer.com/news/security/magniber-ransomware-now-infects-windows-users-via-javascript-files/
