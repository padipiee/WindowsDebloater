<#
.SYNOPSIS
This script disables global telemetry by modifying registry values.

.DESCRIPTION
The script checks and sets the "AllowTelemetry" value in different registry paths to disable global telemetry. It also checks and sets the "Start" value for the "dmwappushsvc" service and the "value" value in the "AllowTelemetry" subkey of "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\System".

.PARAMETER None

.EXAMPLE
.\0016_Disable_global_Telemetry_AllowTelemetry.ps1
Runs the script to disable global telemetry.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version]
#>

# Check and set "AllowTelemetry" value in "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"

function Get-RegistryValue {
  param(
      [string]$path,
      [string]$propertyName
  )

  $propertyExists = (Get-Item -Path $path).Property -contains $propertyName

  if ($propertyExists) {
      return (Get-ItemProperty -Path $path -Name $propertyName).$propertyName
  } else {
      return $null
  }
}



$targetValue = 0
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
if (Test-Path $path) {
  $currentValue = Get-RegistryValue -Path $path -PropertyName "AllowTelemetry"
  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $path -Name "AllowTelemetry" -Value $targetValue
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] AllowTelemetry (Policies\DataCollection) value updated to $targetValue"
  }
  else {
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] AllowTelemetry (Policies\DataCollection) value is already set to $targetValue "
  }
}
else {
  Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] Registry path $path does not exist"
}

# Check and set "AllowTelemetry" value in "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$targetValue = 0
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (Test-Path $path) {
  $currentValue = Get-RegistryValue -Path $path -PropertyName "AllowTelemetry"
  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $path -Name "AllowTelemetry" -Value $targetValue
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] AllowTelemetry (Windows\DataCollection) value updated to $targetValue"
  }
  else {
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] AllowTelemetry (Windows\DataCollection) value is already set to $targetValue "
  }
}
else {
  Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] Registry path $path does not exist"
}

# Check and set "Start" value in "HKLM:\SYSTEM\ControlSet001\Services\dmwappushsvc"
$targetValue = 4
$path = "HKLM:\SYSTEM\ControlSet001\Services\dmwappushsvc"
if (Test-Path $path) {
  $currentValue = Get-RegistryValue -Path $path -PropertyName "Start"
  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $path -Name "Start" -Value $targetValue
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] Start value updated to $targetValue"
  }
  else {
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] Start value is already set to $targetValue"
  }
}
else {
  Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] Registry path $path does not exist"
}

# Check and set "value" value in "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry"
$targetValue = 0
$path = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry"
if (Test-Path $path) {
  $currentValue = (Get-ItemProperty -Path $path -Name "value").value
  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $path -Name "value" -Value $targetValue
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] value updated to $targetValue for $path"
  }
  else {
    Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] value is already set to $targetValue [no change] for $path"
  }
}
else {
  Write-Host "[0016_Disable_global_Telemetry_AllowTelemetry] [no change] Registry path $path does not exist"
}
