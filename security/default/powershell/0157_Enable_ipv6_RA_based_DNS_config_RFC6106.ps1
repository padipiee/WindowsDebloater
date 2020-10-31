Get-NetIPInterface -AddressFamily ipv6 | foreach{
  netsh int ipv6 set int $_.ifIndex rabaseddnsconfig=enable
}

#Ref : https://www.pdq.com/blog/how-to-fix-patch-the-bad-neighbor-exploit-vulnerability/

#Exploit : Bad Neighbor aka Ping of Death Redux (CVE-2020-16898). 


