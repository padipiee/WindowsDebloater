#Application events
mkdir c:\diag
get-eventlog application | sort-object timegenerated | select-object      timegenerated,entrytype,machinename,eventid,source,username,message
#get-eventlog application |      sort-object timegenerated | select-object      timegenerated,entrytype,machinename,eventid,source,username,message |      export-csv c:\diag\application.csv -notype

#Latest detailed 50 security events
Get-EventLog -LogName 'Security'  -Newest 50 |Format-List
#https://evotec.xyz/powershell-everything-you-wanted-to-know-about-event-logs/