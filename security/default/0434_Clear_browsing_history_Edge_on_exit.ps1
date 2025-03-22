# Privacy (optional) - Clear browsing history on exit in Edge.

$userPath = "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Privacy"
$machinePath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Privacy"
$valueName = "ClearBrowsingHistoryOnExit"
$desiredValue = 1

# Create parent keys if they don't exist for User
if (!(Test-Path $userPath)) {
    New-Item -Path $userPath -Force | Out-Null
    Write-Host "Created registry key: $userPath"
}

# Set value for User if needed
$currentUserValue = Get-ItemProperty -Path $userPath -Name $valueName -ErrorAction SilentlyContinue
if ($null -eq $currentUserValue -or $currentUserValue.$valueName -ne $desiredValue) {
    Set-ItemProperty -Path $userPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "Updated User registry: Set $valueName to $desiredValue"
} else {
    Write-Host "User registry value already set correctly"
}

# Create parent keys if they don't exist for Machine
if (!(Test-Path $machinePath)) {
    New-Item -Path $machinePath -Force | Out-Null
    Write-Host "Created registry key: $machinePath"
}

# Set value for Machine if needed
$currentMachineValue = Get-ItemProperty -Path $machinePath -Name $valueName -ErrorAction SilentlyContinue
if ($null -eq $currentMachineValue -or $currentMachineValue.$valueName -ne $desiredValue) {
    Set-ItemProperty -Path $machinePath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "Updated Machine registry: Set $valueName to $desiredValue"
} else {
    Write-Host "Machine registry value already set correctly"
}