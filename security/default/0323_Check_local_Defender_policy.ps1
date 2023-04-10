
function Get-WindowsDefenderPolicy {
  # Check if the machine is part of an Active Directory domain
  $domain = (Get-WmiObject -Query "SELECT * FROM Win32_ComputerSystem").Domain
  if ($domain -eq $null -or $domain -eq "") {
      Write-Output "Error: The machine is not part of an Active Directory domain."
      return
  }

  # Run gpresult command to get Group Policy results
  $gpresult = gpresult /SCOPE Computer /Z | Out-String

  # Check if Windows Defender policies are applied
  if ($gpresult -match "Windows Defender") {
      $matches = $gpresult | Select-String "Windows Defender"
      Write-Output "Windows Defender policies:"
      foreach ($match in $matches) {
          Write-Output $match.Line
      }
  } else {
      Write-Output "Windows Defender policies are not found in local Group Policy results."
  }
}

Get-WindowsDefenderPolicy
