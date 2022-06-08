#Application events
mkdir c:\diag
get-eventlog application | sort-object timegenerated | select-object      timegenerated,entrytype,machinename,eventid,source,username,message
#get-eventlog application |      sort-object timegenerated | select-object      timegenerated,entrytype,machinename,eventid,source,username,message |      export-csv c:\diag\application.csv -notype
