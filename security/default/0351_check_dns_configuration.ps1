<#
.SYNOPSIS
  PowerShell script to extract DNS configuration.

.DESCRIPTION
  This script retrieves the DNS servers for each network adapter that is currently up and running. It also checks if the DNS servers support encryption, such as DNS over HTTPS (DoH), although the actual detection of encryption is not implemented in this script.

.PARAMETER adapterName
  Specifies the name of the network adapter for which to retrieve the DNS servers.

.OUTPUTS
  The script outputs the following information for each adapter:
  - Adapter Name: The name of the network adapter.
  - DNS Servers: The list of DNS server addresses configured for the adapter.
  - Encrypted Preferred Status: The status of encryption support for the DNS servers. Currently, this is a placeholder and requires manual verification.

.EXAMPLE
  PS> .\0351_check_dns_configuration.ps1
  Adapter Name: Ethernet
  DNS Servers: 192.168.1.1, 8.8.8.8
  Encrypted Preferred Status: Unknown - Manual verification needed

.NOTES
  - This script requires administrative privileges to run.
  - The actual detection of DNS encryption is not implemented in this script and requires manual verification.
#>
# PowerShell Script to Extract DNS Configuration

# Function to Get DNS Servers for a Given Adapter
function Get-DnsServers {
  param (
    [string]$adapterName
  )

  try {
    $dnsServers = Get-DnsClientServerAddress -InterfaceAlias $adapterName -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses
    return $dnsServers
  }
  catch {
    Write-Error "Error retrieving DNS servers for adapter '$adapterName': $_"
    return $null
  }
}

# Function to Check if DNS is Encrypted (This is a placeholder function as actual detection isn't straightforward)
function IsDnsEncrypted {
  param (
    [string[]]$dnsServers
  )

  # Placeholder: This should contain logic to verify if DNS servers support DoH or other encryption methods
  # Currently, this would require an external service or a database of known DoH-supporting servers.
  return "Unknown - Manual verification needed"
}

# Main Script
try {
  $adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
  foreach ($adapter in $adapters) {
    $dnsServers = Get-DnsServers -adapterName $adapter.Name
    if ($dnsServers) {
      $encryptionStatus = IsDnsEncrypted -dnsServers $dnsServers

      Write-Output "Adapter Name: $($adapter.Name)"
      Write-Output "DNS Servers: $($dnsServers -join ', ')"
      Write-Output "Encrypted Preferred Status: $encryptionStatus"
      Write-Output ""
    }
  }
}
catch {
  Write-Error "An error occurred: $_"
}
