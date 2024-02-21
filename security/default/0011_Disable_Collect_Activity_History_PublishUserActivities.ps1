<#
.SYNOPSIS
Disables the collection of activity history in Windows 10 and Windows 11.

.DESCRIPTION
This script disables the collection of activity history in Windows 10 by modifying the registry value for PublishUserActivities.

.NOTES
- This script requires administrative privileges to modify the registry.
- For more information about activity history in Windows 10, refer to the following sources:
  - https://www.theregister.co.uk/2018/12/13/windows_10_carry_on_slurping/
  - https://www.howtogeek.com/fyi/windows-10-sends-your-activity-history-to-microsoft-even-if-you-tell-it-not-to/
  - https://www.tenforums.com/tutorials/100341-enable-disable-collect-activity-history-windows-10-a.html#option2
  - https://www.techradar.com/news/windows-10-might-be-recording-and-uploading-your-pcs-activity-history-without-you-knowing

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
Disable-CollectActivityHistory

#>
$publishUserActivitiesPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$publishUserActivitiesValue = Get-ItemProperty -Path $publishUserActivitiesPath

Write-Host "[0011_Disable_Collect_Activity_History_PublishUserActivities] Initial value of PublishUserActivities: $($publishUserActivitiesValue.PublishUserActivities)"

if ($publishUserActivitiesValue.PublishUserActivities -ne 0) {
  Set-ItemProperty -Path $publishUserActivitiesPath -Name "PublishUserActivities" -Value 0
  $publishUserActivitiesValue = Get-ItemProperty -Path $publishUserActivitiesPath
  Write-Host "[0011_Disable_Collect_Activity_History_PublishUserActivities] Updated value of PublishUserActivities: $($publishUserActivitiesValue.PublishUserActivities)"
}
else {
  Write-Host "[0011_Disable_Collect_Activity_History_PublishUserActivities] No change: PublishUserActivities is already set to 0"
}


