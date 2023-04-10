# Install Rsat.GroupPolicy.Management.Tools

$capabilityInstalled_Rsat_GroupPolicy_Management_Tools = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'Rsat.GroupPolicy.Management.Tools*' } | Select-Object -Last 1 State | Select-Object -Last 2 | ForEach-Object { $_.State -replace '.*:\s*','' }

# Install RSAT
#Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online

# If Rsat.ServerCore.Install.Tools capability is not installed, install RSAT feature
if (!$capabilityInstalled_Rsat_GroupPolicy_Management_Tools) {
    Write-Host "Rsat.GroupPolicy.Management.Tools capability not found. Installing RSAT feature..."
    Add-WindowsCapability -Online -Name "Rsat.GroupPolicy.Management.Tools~*"
    $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'Rsat.GroupPolicy.Management.Tools*' } | Select-Object -Last 1 | ForEach-Object { $_.Name }
    
    Write-Host "RSAT feature installed. Version: $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version"
} else {
    $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'Rsat.GroupPolicy.Management.Tools*' } | Select-Object -Last 1 | ForEach-Object { $_.Name }
    Write-Host "Rsat.GroupPolicy.Management.Tools capability is already installed. Version: $capabilityInstalled_Rsat_GroupPolicy_Management_Tools_version"
}
