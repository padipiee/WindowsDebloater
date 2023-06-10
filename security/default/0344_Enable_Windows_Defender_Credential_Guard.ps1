## Enable Windows Defender Credential Guard
### ref 0227_Enable_vitualization_based_Security.bat
### https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard-manage




$policyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
$policyValueName = "EnableVirtualizationBasedSecurity"
$policyValue = 1

$currentValue = Get-ItemProperty -Path $policyPath -Name $policyValueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue.$policyValueName -ne $policyValue) {
    Set-ItemProperty -Path $policyPath -Name $policyValueName -Value $policyValue
    # Restart the system to apply the changes
    # Restart-Computer   #activate if you want it
    Write-Host "The value of $policyValueName was configured to $policyValue."
}
else {
    Write-Host "The value of $policyValueName is already set to $policyValue."
}




#   # 18.8.5.5 (NG) Ensure 'Turn On Virtualization Based Security: Credential Guard Configuration' is set to 'Enabled with UEFI lock'
#   Registry 'LsaCfgFlags' {
#     Ensure     = 'Present'
#     Key        = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'
#     ValueName  = 'LsaCfgFlags'
#     ValueType  = 'DWord'
#     ValueData  = '1'
# }
#$exist = Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"
#$traitement = Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" |Select-Object LsaCfgFlags
#$traitement = $traitement.LsaCfgFlags
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$registryValueName = "LsaCfgFlags"
$desiredValue = 1  # Set the desired value: 1 for enabling with UEFI lock, 2 for enabling without lock, 0 for disabling

if (Test-Path -Path $registryPath) {
    $currentValue = Get-ItemPropertyValue -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue
}
else {
    $currentValue = $null
}

if ($currentValue -ne $desiredValue) {
    if ($null -eq $currentValue) {
        New-ItemProperty -Path $registryPath -Name $registryValueName -Value $desiredValue -PropertyType DWORD -Force
    }
    else {
        Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $desiredValue
    }
    Write-Host "Windows Defender Credential Guard has been enabled with the desired setting."
}
else {
    Write-Host "Windows Defender Credential Guard is already enabled with the desired setting."
}






