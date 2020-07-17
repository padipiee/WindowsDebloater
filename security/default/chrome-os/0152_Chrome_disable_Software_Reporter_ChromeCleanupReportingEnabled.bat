:: Disable Chrome Software Reporter Tool using Chrome Policies

reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v ChromeCleanupReportingEnabled /t REG_DWORD /d 0

::Enter 0 for disabling the reporting functionality. Enter 1 to enable the reporting functionality.
::https://www.itechtics.com/disable-software-reporter-tool/
