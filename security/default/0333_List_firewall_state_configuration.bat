REM This script lists the current state and configuration of the Windows Firewall using the netsh command.
REM The first command "netsh advfirewall firewall dump" dumps the current state of the firewall.
REM The second command "netsh firewall show state" shows the current state of the firewall.
REM The third command "netsh firewall show config" shows the current configuration of the firewall.
netsh advfirewall firewall dump

netsh firewall show state
netsh firewall show config