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
