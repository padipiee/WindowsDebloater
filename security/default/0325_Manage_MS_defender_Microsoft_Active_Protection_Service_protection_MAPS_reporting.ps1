
#https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/enable-cloud-protection-microsoft-defender-antivirus?view=o365-worldwide



function Set-WDMapsReporting {
  [CmdletBinding()]
  param (
      [Parameter(Mandatory=$true)]
      [ValidateSet("0", "1")]
      [string]$Status
  )


# 0: Disabled. Send no information to Microsoft. This is the default value.
# 1: Basic membership. Send basic information to Microsoft about detected software, including where the software came from, the actions that you apply or that apply automatically, and whether the actions succeeded.
# 2: Advanced membership. In addition to basic information, send more information to Microsoft about malicious software, spyware, and potentially unwanted software, including the location of the software, file names, how the software operates, and how it affects your computer.

  # (0 for Off, 1 for On-Basic membership)
  $mapsReportingValue = if ($Status -eq "1") {1} else {0}
  Write-Host "Try to : Set-MpPreference -MAPSReporting $mapsReportingValue"

  # Check if Windows Defender MAPSReporting is already set to desired status
  $currentStatus = Get-MpPreference | Select-Object -ExpandProperty MAPSReporting
  if ($currentStatus -eq $mapsReportingValue) {
      Write-Host "Windows Defender MAPSReporting is already set to '$Status' mode."
  } else {
      # Set Windows Defender MAPSReporting to desired status
      Set-MpPreference -MAPSReporting $mapsReportingValue

      # Verify if the setting was successful
      $newStatus = Get-MpPreference | Select-Object -ExpandProperty MAPSReporting
      if ($newStatus -eq $mapsReportingValue) {
          Write-Host "Windows Defender MAPSReporting has been successfully set to '$Status' mode."
      } else {
          Write-Host "Failed to set Windows Defender MAPSReporting to '$Status' mode."
      }
  }
}


Set-WDMapsReporting
