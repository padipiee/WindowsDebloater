Write-Output "[0363] - Setting up Chocolatey software package manager"
Get-PackageProvider -Name chocolatey -Force

Write-Output "[0363] - Setting up Full Chocolatey Install"
Install-Package -Name Chocolatey -ProviderName chocolatey -Force
$chocopath = (Get-Package chocolatey | Where-Object { $_.Name -eq "chocolatey" } | Select-Object @{N = "Source"; E = { ((($a = ($_.Source -split "\\"))[0..($a.length - 2)]) -join "\"), "Tools\chocolateyInstall" -join "\" } } | Select-Object -ExpandProperty Source)
& $chocopath "upgrade all -y"
choco install chocolatey-core.extension --force

Write-Output "[0363] - Creating daily task to automatically upgrade Chocolatey packages"

$ScheduledJob = @{
  Name               = "Chocolatey Daily Upgrade"
  ScriptBlock        = { choco upgrade all -y }
  Trigger            = New-JobTrigger -Daily -at 3am
  ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork
}
Register-ScheduledJob @ScheduledJob
