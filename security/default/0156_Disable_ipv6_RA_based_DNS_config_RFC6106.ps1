Get-NetIPInterface -AddressFamily ipv6 | foreach{
  $rfc = (& netsh int ipv6 show int $_.ifIndex) -match '(RFC 6106)'
  if($rfc -like "*enabled"){
       netsh int ipv6 set int $_.ifIndex rabaseddnsconfig=disable
  }
}


#Ref : https://www.pdq.com/blog/how-to-fix-patch-the-bad-neighbor-exploit-vulnerability/

#Exploit : Bad Neighbor aka Ping of Death Redux (CVE-2020-16898). 


