cls
echo 0002 - Deleting spyware firewall rules... 
powershell -Command "& {Get-NetFirewallRule | Where { $_.Group -like '*@{*' } | Remove-NetFirewallRule;}"
powershell -Command "& {Get-NetFirewallRule | Where { $_.Group -eq 'DiagTrack' } | Remove-NetFirewallRule;}"
powershell -Command "& {Get-NetFirewallRule | Where { $_.DisplayGroup -eq 'Delivery Optimization' } | Remove-NetFirewallRule;}"
powershell -Command "& {Get-NetFirewallRule | Where { $_.DisplayGroup -like 'Windows Media Player Network Sharing Service*' } | Remove-NetFirewallRule;}"
cls