
# list all scheduled tasks
schtasks /query /v /fo csv | ConvertFrom-CSV | Select -Property "TaskName","Task To Run" | Where {$_.TaskName -notcontains "TaskName"} | FL