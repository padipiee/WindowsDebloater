# This script modifies the registry to turn off the activity history feature.

# Define the Set-RegistryValue function
function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    # Check if the path exists, and if not, create it
    if (!(Test-Path $path)) {
        $currentPath = "HKCU:"
        $path.Substring(5).Split('\') | ForEach-Object {
            $currentPath = Join-Path -Path $currentPath -ChildPath $_
            if (!(Test-Path $currentPath)) {
                New-Item -Path $currentPath | Out-Null
            }
        }
    }

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
    $title = "[0383_Disable_Store_my_activity_histor]"

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType DWORD -Force
        Write-Host " $title [$propertyName] created and set to $value for $path"
    } elseif ($existingValue.$propertyName -ne $value) {
        # If the property exists and its value is not $value, set its value
        Set-ItemProperty -Path $path -Name $propertyName -Value $value
        Write-Host "$title [$propertyName] adjusted to $value for $path"
    } else {
        # If the property exists and its value is already $value
        Write-Host "$title [$propertyName] is already set to $value. No modification for $path"
    }
}

# Set the registry paths
$RegistryPath1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ActivityFeed\Settings"
$RegistryPath2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

# Set the values to disable activity history
Set-RegistryValue -Path $RegistryPath1 -PropertyName "EnableActivityFeed" -Value 0
Set-RegistryValue -Path $RegistryPath2 -PropertyName "EnableActivityFeed" -Value 0
