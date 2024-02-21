

#https://winaero.com/blog/stop-windows-10-spying-on-you-using-just-windows-firewall/
#https://www.pcministry.com/winsrv2016_telemetry/summary/top_ip_addresses_for_telemetry_over_https/

Set-NetFirewallProfile -all
Write-Host "[0059.001_Block_telemetry_microsoft_firewall_vortex-data-microsoft_191-232-139-254]"
netsh advfirewall firewall add rule name="telemetry_vortex.data.microsoft.com_191.232.139.254" dir=out action=block remoteip=191.232.139.254 enable=yes
