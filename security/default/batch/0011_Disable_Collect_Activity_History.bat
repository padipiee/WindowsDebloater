:: Disable Collect Activity History
:: https://www.theregister.co.uk/2018/12/13/windows_10_carry_on_slurping/
:: https://www.howtogeek.com/fyi/windows-10-sends-your-activity-history-to-microsoft-even-if-you-tell-it-not-to/
:: https://www.tenforums.com/tutorials/100341-enable-disable-collect-activity-history-windows-10-a.html#option2
:: https://www.techradar.com/news/windows-10-might-be-recording-and-uploading-your-pcs-activity-history-without-you-knowing

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f 


