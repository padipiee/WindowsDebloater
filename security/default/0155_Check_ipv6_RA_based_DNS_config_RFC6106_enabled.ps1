Get-NetIPInterface -AddressFamily ipv6 | foreach{
   [PSCustomObject]@{
        "IfIndex"   = (& netsh int ipv6 show int $_.ifIndex) -match 'IfIndex' -replace "ifindex\s*:","" | Out-String
        "RFC"   = (& netsh int ipv6 show int $_.ifIndex) -match '(RFC 6106)' -replace "RA Based DNS Config \(RFC 6106\)\s*:","" | Out-String
    }
}


#Ref : https://www.pdq.com/blog/how-to-fix-patch-the-bad-neighbor-exploit-vulnerability/

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



#PS C:...> netsh int ipv6 show int ..
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
