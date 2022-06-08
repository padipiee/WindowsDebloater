#Get-EventLog-security
#Latest detailed 50 security events
Get-EventLog -LogName 'Security'  -Newest 50 |Format-List
#https://evotec.xyz/powershell-everything-you-wanted-to-know-about-event-logs/