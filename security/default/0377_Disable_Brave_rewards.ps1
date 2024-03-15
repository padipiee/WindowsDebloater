<#
.SYNOPSIS
Disables the Brave Rewards icon in the Brave Browser.
This hides the Brave Rewards icon in the browser.

.DESCRIPTION
This script disables the Brave Rewards icon in the Brave Browser by modifying the registry value of "ShowBraveRewardsIcon" under "HKCU:\Software\BraveSoftware\Brave-Browser". If the registry value does not exist, it will be created and set to 0. If the registry value already exists and is not 0, it will be adjusted to 0. If the registry value is already set to 0, no modification will be made.

.PARAMETER path
The registry path where the property exists or will be created.

.PARAMETER propertyName
The name of the property to modify or create.

.PARAMETER value
The value to set for the property.

.EXAMPLE
Set-RegistryValue -Path "HKCU:\Software\BraveSoftware\Brave-Browser" -PropertyName "ShowBraveRewardsIcon" -Value 0
#>

$title = "[0377_Disable_Brave_rewards]"
function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
   

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType DWORD -Force
        Write-Host "$title [$propertyName] created and set to $value"
    }
    elseif ($existingValue.$propertyName -ne $value) {
        # If the property exists and its value is not $value, set its value
        Set-ItemProperty -Path $path -Name $propertyName -Value $value
        Write-Host "$title [$propertyName] adjusted to $value"
    }
    else {
        # If the property exists and its value is already $value
        Write-Host "$title [$propertyName] is already set to $value. No modification"
    }
}

Set-RegistryValue -Path "HKCU:\Software\BraveSoftware\Brave-Browser" -PropertyName "ShowBraveRewardsIcon" -Value 0

##################### DSC Configuration #####################    

function Disable-BraveRewards {
    param()

    # Check if PSDesiredStateConfiguration module is available
    $module = Get-Module -ListAvailable -Name PSDesiredStateConfiguration -ErrorAction SilentlyContinue

    if ($null -eq $module) {
        Write-Host "$title [$propertyName] The module 'PSDesiredStateConfiguration' is not found. Exiting the script."
        exit
    } else {
        Write-Host "$title [$propertyName] The module 'PSDesiredStateConfiguration' is found. Details:"
        Write-Host "$title [$propertyName] Name: $($module.Name)"
        Write-Host "$title [$propertyName] Version: $($module.Version)"
        Write-Host "$title [$propertyName] Path: $($module.Path)"
        
        
    }


    try {
        Get-Command Import-DscResource -ErrorAction Stop
    }
    catch {
        Write-Host "$title [$propertyName] The cmdlet 'Import-DscResource' is not recognized. Exiting the script."
        exit
    }

    Configuration DisableBraveRewards {
        Import-Module PSDesiredStateConfiguration
        Write-Host "$title [$propertyName] PSDesiredStateConfiguration explicitely imported"
        Import-DscResource -ModuleName PSDesiredStateConfiguration

      Node 'localhost' {
        Registry ShowBraveRewardsIcon {
            Ensure      = 'Present'
            Key         = 'HKEY_CURRENT_USER\Software\BraveSoftware\Brave-Browser'
            ValueName   = 'ShowBraveRewardsIcon'
            ValueData   = '0'
            ValueType   = 'DWord'
        }
      }
    }

    # Generate the MOF file
    isableBraveRewards -OutputPath "C:\Windows\Temp"

    # Apply the configuration
    Start-DscConfiguration -Path "C:\Windows\Temp" -Wait -Verbose -Force
    Write-Host "$title [$propertyName] Start-DscConfiguration..."
}

# Check PowerShell version
$PSVersion = $PSVersionTable.PSVersion.Major

if ($PSVersion -eq 5) {
    # PowerShell 5.0 or later, execute DSC configuration
    Write-Host "$title [$propertyName] PowerShell 5.x detected...Testing WinRM service status..."
    $WinRMService = Get-Service -Name WinRM

    if ($WinRMService.Status -eq 'Running') {
        Write-Host  "$title [$propertyName] WinRM service is running, configuring DSC to disable Brave Rewards...."
        Disable-BraveRewards
    }
    else {
        Write-Host "$title [$propertyName] WinRM service is not running."
    }
}
else {
    # PowerShell version is less than 5.0, display a message
    Write-Host "$title [$propertyName] This script requires PowerShell 5.0 or later. You are currently running PowerShell $PSVersion."
}
