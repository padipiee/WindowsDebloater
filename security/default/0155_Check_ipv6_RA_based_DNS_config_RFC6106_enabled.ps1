<#
.SYNOPSIS
Checks if IPv6 RA-based DNS configuration (RFC 6106) is enabled on the network interfaces and identifies Wi-Fi adapters.

.DESCRIPTION
This script retrieves the network interfaces with IPv6 address family and checks if the RA-based
 DNS configuration (RFC 6106) is enabled. It also identifies if the interface is a Wi-Fi adapter.
  It uses the `Get-NetIPInterface` and `Get-NetAdapter` cmdlets, and the `netsh` command to retrieve the configuration details.

.PARAMETER None

.INPUTS
None. You cannot pipe objects to this script.

.OUTPUTS
[PSCustomObject] with the following properties:
- IfIndex: The interface index of the network interface.
- IsWiFi: Boolean indicating if the interface is a Wi-Fi adapter.
- RFC: The status of the RA-based DNS configuration (RFC 6106) on the network interface.

.NOTES
- This script requires administrative privileges to run.
- The `netsh` command is used to retrieve the configuration details. Make sure it is available on the system where the script is executed.
- Wi-Fi adapters are identified by an InterfaceType of 71 (IF_TYPE_IEEE80211).

.EXAMPLE
PS C:\> .\0155_Check_ipv6_RA_based_DNS_config_RFC6106_enabled.ps1
    IfIndex IsWiFi RFC
    ------- ------ ---
    28      True   enabled
    15      False  disabled

.LINK
https://www.pdq.com/blog/how-to-fix-patch-the-bad-neighbor-exploit-vulnerability/
#Exploit : Bad Neighbor aka Ping of Death Redux (CVE-2020-16898). 


#CVE-2020-16898:
#
#x=ICMPv6NDOptRDNSS()                                                            
#[ ICMPv6 Neighbor Discovery Option - Recursive DNS Server Option ]
#  type= 25
#  len= None
#  res= None
#  lifetime= 4294967295
#  dns= [  ]



#PS C:...> netsh int ipv6 show int 28
#
#Interface vEthernet (...) Parameters
#----------------------------------------------
#IfLuid                             : ethernet_xxxx
#IfIndex                            : 28
#State                              : connected
#Metric                             : 5000
#Link MTU                           : 1500 bytes
#Reachable Time                     : 21000 ms
#Base Reachable Time                : 30000 ms
#Retransmission Interval            : 1000 ms
#DAD Transmits                      : 1
#Site Prefix Length                 : 0
#Site Id                            : 1
#Forwarding                         : disabled
#Advertising                        : disabled
#Neighbor Discovery                 : enabled
#Neighbor Unreachability Detection  : enabled
#Router Discovery                   : enabled
#Managed Address Configuration      : disabled
#Other Stateful Configuration       : disabled
#Weak Host Sends                    : disabled
#Weak Host Receives                 : disabled
#Use Automatic Metric               : disabled
#Ignore Default Routes              : disabled
#Advertised Router Lifetime         : 1800 seconds
#Advertise Default Route            : disabled
#Current Hop Limit                  : 0
#Force ARPND Wake up patterns       : disabled
#Directed MAC Wake up patterns      : disabled
#ECN capability                     : application
#RA Based DNS Config (RFC 6106)     : enabled
#DHCP/Static IP coexistence         : enabled


#>
Get-NetIPInterface -AddressFamily ipv6 | ForEach-Object {
    # Execute netsh command once for the current interface
    $netshOutputLines = netsh int ipv6 show interface $_.ifIndex

    # Extract the line containing RFC 6106 configuration
    $rfcConfigLine = $netshOutputLines | Where-Object { $_ -match 'RA Based DNS Config \(RFC 6106\)' }

    # Determine the RFC status from the extracted line
    $rfcStatus = if ($rfcConfigLine) {
        # Extract the value after the colon and trim whitespace
        ($rfcConfigLine -replace '.*:\s*', '').Trim()
    } else {
        'N/A' # Value if the RFC 6106 line is not found
    }

    # Get the network adapter to check its type
    $adapter = Get-NetAdapter -InterfaceIndex $_.ifIndex -ErrorAction SilentlyContinue
    $isWiFi = $false
    if ($adapter) {
        # InterfaceType 71 is for IEEE 802.11 (Wi-Fi)
        if ($adapter.InterfaceType -eq 71) {
            $isWiFi = $true
        }
    }

   [PSCustomObject]@{
        "IfIndex" = $_.ifIndex # Use the direct numerical IfIndex from Get-NetIPInterface
        "IsWiFi"  = $isWiFi
        "RFC"     = $rfcStatus
    }
}





