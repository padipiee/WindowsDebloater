# Set DNS

Get-DnsClientServerAddress

#
Get-DnsClientServerAddress -InterfaceIndex 9
#set-DnsClientServerAddress -InterfaceIndex 9 -ServerAddresses ("8.8.8.8","1.1.1.1")

# Quad9 DNS
set-DnsClientServerAddress -InterfaceIndex 9 -ServerAddresses ("9.9.9.9","1.1.1.1")

# Ref  https://github.com/bitbeans/SimpleDnsCrypt

