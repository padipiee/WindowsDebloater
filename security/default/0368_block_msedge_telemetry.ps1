<#
.SYNOPSIS
This script is used to block Microsoft Edge telemetry by adding a new outbound rule to the Windows Firewall.

.DESCRIPTION
The script checks if a firewall rule with the specified name already exists. If the rule exists, it prints a message. 
If the rule does not exist, it adds a new outbound rule to the Windows Firewall that blocks the specified IP address.

.PARAMETER ruleName
The name of the firewall rule. In this case, it's "telemetry_a-0001.a-msedge.net".

.PARAMETER remoteIP
The IP address that the rule will block. In this case, it's "204.79.197.200".

.EXAMPLE
.\0368_block_msedge_telemetry.ps1

#>

$ruleName = "telemetry_a-0001.a-msedge.net"
$remoteIP = "204.79.197.200"

$existingRule = netsh advfirewall firewall show rule name="$ruleName" dir=out | Where-Object { $_ -match "RemoteIP:\s+$remoteIP" }

if ($existingRule) {
    Write-Host "[0368_block_msedge_telemetry] Firewall rule '$ruleName' already exists."
} else {
    netsh advfirewall firewall add rule name="$ruleName" dir=out action=block remoteip=$remoteIP enable=yes
    Write-Host "[0368_block_msedge_telemetry] Firewall rule '$ruleName' added successfully."
}