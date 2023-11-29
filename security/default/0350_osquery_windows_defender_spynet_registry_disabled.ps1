<#
.SYNOPSIS
This script executes a query using osqueryi to check the status of Windows Defender Spynet registry disabled. It also retrieves the status of DisableBlockAtFirstSeen from Windows Defender preferences.

.DESCRIPTION
The script imports the powershell-yaml module and loads a YAML file containing the query to be executed. It then converts the YAML content to a PowerShell object and extracts the query from it. The query is logged and executed using osqueryi. The result of the query is logged as well.

Next, the script retrieves the DisableBlockAtFirstSeen status from Windows Defender preferences using the Get-MpPreference cmdlet. The status is logged.

.EXAMPLE
.\0350_osquery_windows_defender_spynet_registry_disabled.ps1

This example runs the script and executes the query to check the status of Windows Defender Spynet registry disabled. It also retrieves the DisableBlockAtFirstSeen status.

.INPUTS
None

.OUTPUTS
None

.NOTES
Author: [Your Name]
Date: [Current Date]

.LINK
[Link to more information about osquery](https://osquery.io/)

#>
# As admin...
Import-Module powershell-yaml

try {
  # Load the YAML file
  $yamlContent = Get-Content -Path '0349_windows_defender_spynet_registry_disabled.yaml' -Raw

  # Convert the YAML content to a PowerShell object
  $yamlObject = ConvertFrom-Yaml $yamlContent

  # Extract the query from the PowerShell object
  $query = $yamlObject.windows_defender_spynet_registry_disabled.query

  # Log the query
  Write-Host "Running query: $query"

  # Run the query with osqueryi
  $query = @"
$query
"@

  $queryResult = echo $query | & 'C:\Program Files\osquery\osqueryi.exe' --json

  # Log the query result
  $queryResult = $queryResult | ConvertTo-Json -Depth 100
  Write-Host "Query result: $queryResult"
}
catch {
  Write-Host "Error occurred while executing the query: $_"
}

try {
  $preferences = Get-MpPreference
  $blockAtFirstSeenStatus = $preferences.DisableBlockAtFirstSeen

  # Log the status
  Write-Host "DisableBlockAtFirstSeen status: $blockAtFirstSeenStatus"
}
catch {
  Write-Host "Error occurred while getting DisableBlockAtFirstSeen status: $_"
}