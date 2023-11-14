<#
.SYNOPSIS
Lists all network interfaces and their IPv4 addresses along with DNS server addresses.

.DESCRIPTION
This script retrieves the network interface configuration and DNS server addresses for IPv4 and displays them in a formatted table.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
./0332_List_all_network_interfaces.ps1
This command lists all network interfaces and their IPv4 addresses along with DNS server addresses.

.NOTES
Author: Unknown
Date: Unknown
#>
Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
Get-DnsClientServerAddress -AddressFamily IPv4 | ft