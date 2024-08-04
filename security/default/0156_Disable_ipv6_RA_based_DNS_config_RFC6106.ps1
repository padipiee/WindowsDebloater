<#
.SYNOPSIS
Disables IPv6 RA-based (Router Advertisements) DNS configuration (RFC6106) on network interfaces.

.DESCRIPTION
This script disables the IPv6 RA-based DNS configuration (RFC6106) on all network interfaces that have IPv6 enabled. 
It uses the `Get-NetIPInterface` cmdlet to retrieve all IPv6 interfaces and then checks if the RFC 6106 option 
is enabled for each interface using the `netsh` command. If the option is enabled, 
it disables the RA-based DNS configuration using the `netsh` command.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
Disables the IPv6 RA-based DNS configuration on all network interfaces.

.NOTES
This script requires administrative privileges to run.
https://oswalt.dev/2011/09/ipv6-hacking-thc-ipv6-part-2/
https://www.mdpi.com/2073-431X/12/6/125
#>
Get-NetIPInterface -AddressFamily ipv6 | ForEach-Object {
  $interface = $_
  $rfc = (& netsh int ipv6 show int $interface.ifIndex) -match '(RFC 6106)'
  if ($rfc -like "*enabled") {
    Write-Host "RA-based DNS configuration is enabled on interface $($interface.InterfaceAlias). Disabling..."
    netsh int ipv6 set int $interface.ifIndex rabaseddnsconfig=disable
    if ($?) {
      Write-Host "RA-based DNS configuration has been successfully disabled on interface $($interface.InterfaceAlias)."
    } else {
      Write-Host "Failed to disable RA-based DNS configuration on interface $($interface.InterfaceAlias)."
    }
  } else {
    Write-Host "RA-based DNS configuration is already disabled on interface $($interface.InterfaceAlias)."
  }
}


#Ref : https://www.pdq.com/blog/how-to-fix-patch-the-bad-neighbor-exploit-vulnerability/

#Exploit : Bad Neighbor aka Ping of Death Redux (CVE-2020-16898). 


