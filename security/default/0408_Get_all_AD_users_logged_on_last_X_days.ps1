## Require AD module and environment with AD cmdlets
$date = (get-date) - (new-timespan -days 5)
Get-ADUser -Filter 'lastLogon -gt $date'


