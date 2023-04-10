# Check if Rsat.ServerCore.Install.Tools capability is installed
Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property DisplayName, Stat
