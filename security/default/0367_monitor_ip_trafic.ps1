# Define the path to the script that contains the IPs
$scriptPath = "0059_Block_telemetry_microsoft_firewall.ps1"

# Parse the script to extract the IP addresses
$ipsToMonitor = Select-String -Path $scriptPath -Pattern 'remoteip=([0-9\.]+)' | ForEach-Object { $_.Matches.Groups[1].Value }

# Continuously monitor network traffic
while ($true) {
  foreach ($ipToMonitor in $ipsToMonitor) {
      # Get the current network connections
      $connections = netstat -n | Where-Object { $_ -match "$ipToMonitor" }

      # If there are any connections to the monitored IP address, output them
      if ($connections) {
          Write-Output "Connections to $ipToMonitor detected:"
          $connections
      }
  }

  # Wait for a short period before checking again
  Start-Sleep -Seconds 5
}