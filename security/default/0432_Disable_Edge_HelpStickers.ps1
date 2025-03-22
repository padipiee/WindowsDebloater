# Disable help prompt in Edge UI

# Registry paths
$registryPaths = @(
    [PSCustomObject]@{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI"
        Name = "DisableHelpSticker"
        Type = "DWord"
        Value = 1
    },
    [PSCustomObject]@{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI"
        Name = "DisableHelpSticker" 
        Type = "DWord"
        Value = 1
    }
)

foreach ($reg in $registryPaths) {
    # Test if registry path exists, if not create it
    if (-not (Test-Path -Path $reg.Path)) {
        New-Item -Path $reg.Path -Force | Out-Null
        Write-Host "Created registry path: $($reg.Path)"
    }
    
    # Check if the registry value exists and has the correct value
    $currentValue = Get-ItemProperty -Path $reg.Path -Name $reg.Name -ErrorAction SilentlyContinue
    
    if ($null -eq $currentValue -or $currentValue.$($reg.Name) -ne $reg.Value) {
        # Set the registry value
        New-ItemProperty -Path $reg.Path -Name $reg.Name -PropertyType $reg.Type -Value $reg.Value -Force | Out-Null
        Write-Host "Set $($reg.Path)\$($reg.Name) to $($reg.Value)"
    } else {
        Write-Host "$($reg.Path)\$($reg.Name) is already set to $($reg.Value). No change needed."
    }
}