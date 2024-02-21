
<#
.SYNOPSIS
Display a message in order to disable NVIDIA Container Telemetry by disablong a dll (rename or deletion).

.DESCRIPTION
Display a message in order to disable NVIDIA Container Telemetry by disabling a dll (rename or deletion).

.PARAMETER directory
The directory where the NVIDIA Container Telemetry files are located.

.INPUTS
None.

.OUTPUTS
None.

.EXAMPLE
Disable-NVIDIAContainerTelemetry -Directory "C:\Program Files\NVIDIA Corporation\NvContainer"

#>

$directory = "C:\Program Files\NVIDIA Corporation\NvContainer"

if (Test-Path -Path $directory) {
  $files = Get-ChildItem -Path $directory -Filter "*Telemetry*" -File

  foreach ($file in $files) {
    Write-Output "[0044_Disable_NVIDIA_Container_Telemetry] {MANUAL !} Disable $($file.FullName)"
  }
}
else {
  Write-Output "[0044_Disable_NVIDIA_Container_Telemetry] NVIDIA Container was not found."
}
