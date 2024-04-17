# Adjust Brave's startup behavior via the registry (5 # Value indicating to open the New Tab page on startup)

# Define the registry path where Brave's policies are stored
$registryPath = "HKCU:\Software\Policies\BraveSoftware\Brave"

# Define the property name and the desired value
$propertyName = "RestoreOnStartup"
$desiredValue = 5 # Value indicating to open the New Tab page on startup

# Function to check and set the property value
function Set-RegistryPropertyValue {
    param (
        [string]$Path,
        [string]$Name,
        [int]$Value
    )
    $title = "[0400_Brave_RestoreOnStartupOnNewTab]"
    # Check if the property exists by trying to get its value
    try {
        $currentValue = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop
        if ($currentValue -eq $Value) {
            Write-Host "$title No modification needed. The '$Name' property already exists and is set to the desired value ($Value)."
        } else {
            Set-ItemProperty -Path $Path -Name $Name -Value $Value
            Write-Host "$title The '$Name' property has been updated from $currentValue to $Value."
        }
    } catch {
        # The property does not exist, so create it
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
        Write-Host "$title The '$Name' property did not exist and has been created with the value $Value."
    }
}

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # The registry path doesn't exist; create it
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "$title  Registry path '$registryPath' has been created."
}

# Set the property value
Set-RegistryPropertyValue -Path $registryPath -Name $propertyName -Value $desiredValue

