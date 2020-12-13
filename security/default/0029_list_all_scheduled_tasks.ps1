
# list all scheduled tasks
# check via taskschd.msc 
schtasks /query /v /fo csv | ConvertFrom-CSV | Select -Property "TaskName","Task To Run" | Where {$_.TaskName -notcontains "TaskName"} | FL

#Examples to review....
#TaskName    : \Microsoft\Office\OfficeTelemetryAgentFallBack2016
#Task To Run : C:\Program Files (x86)\Microsoft Office\root\Office16\msoia.exe scan upload mininterval:2880

#TaskName    : \Microsoft\Office\OfficeTelemetryAgentLogOn2016
#Task To Run : C:\Program Files (x86)\Microsoft Office\root\Office16\msoia.exe scan upload