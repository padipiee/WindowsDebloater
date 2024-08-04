:: Disable Chrome Software Reporter Tool using Chrome Policies
:: See 0033_Google_reporter_tool_scan_and_send_your_content as Google still send scan reports despite the policy for reporting is disabled

reg query "HKLM\SOFTWARE\Policies\Google\Chrome"
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v ChromeCleanupEnabled /t REG_DWORD /d 0
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v ChromeCleanupReportingEnabled /t REG_DWORD /d 0
reg query "HKLM\SOFTWARE\Policies\Google\Chrome"


::If disabled, should Chrome Cleanup detect unwanted software, it will not report metadata about the scan to Google, overriding any policy 
::set by SafeBrowsingExtendedReportingEnabled.
:: Chrome Cleanup will ask the user if they wish to clean up the unwanted software. 

::Enter 0 for disabling the reporting functionality. Enter 1 to enable the reporting functionality.
::https://www.itechtics.com/disable-software-reporter-tool/

::https://admx.help/?Category=Chrome&Policy=Google.Policies.Chrome::ChromeCleanupReportingEnabled
