<#
.SYNOPSIS
This script disables the Widgets feature in Windows 11 by setting the AllowNewsAndInterests registry value to 0.
## gpedit.msc
## Computer Configuration > Administrative Templates > Windows Components > Widgets with 

## to remove it completely : winget uninstall "windows web experience pack"
## refer to process  MicrosoftWindows.Client.WebExperience
## example C:\Program Files\WindowsApps\MicrosoftWindows.Client.WebExperience_424.1301.270.0_x64__cw5n1h2txyewy\Dashboard\Widgets.exe

# Define the registry path

.DESCRIPTION
The script checks if the registry key "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" exists. If it doesn't exist, the script creates it.
Then, it checks if the value of AllowNewsAndInterests is already set to 0. If it's not, the script sets the value to 0 to disable the Widgets feature.
Finally, the script outputs a message indicating whether the registry value was set or if it was already set to 0.

!! The script check also the GPO value for the same key and value.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
.\0390_Disable_Widgets_AllowNewsAndInterests.ps1
This example runs the script to disable the Widgets feature in Windows 11.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Check if the registry key exists
if (!(Test-Path -Path $registryPath)) {
    # If the registry key does not exist, create it
    New-Item -Path $registryPath -Force | Out-Null
}

# Check if the AllowNewsAndInterests property exists
if ((Get-ItemProperty -Path $registryPath -ErrorAction SilentlyContinue).PSObject.Properties.Name -contains "AllowNewsAndInterests") {
    # If the property exists, get its value
    $AllowNewsAndInterests = (Get-ItemProperty -Path $registryPath).AllowNewsAndInterests
    if ($AllowNewsAndInterests -ne 0) {
        # If the value is not 0, set it to 0
        Set-ItemProperty -Path $registryPath -Name AllowNewsAndInterests -Value 0
        Write-Host "[0390_Disable_Widgets_AllowNewsAndInterests] Registry AllowNewsAndInterests set to 0"
    } else {
        Write-Host "[0390_Disable_Widgets_AllowNewsAndInterests] Registry AllowNewsAndInterests is already set to 0"
    }
} else {
    # If the property does not exist, create it and set its value to 0
    New-ItemProperty -Path $registryPath -Name AllowNewsAndInterests -Value 0 -PropertyType DWORD -Force | Out-Null
    Write-Host "[0390_Disable_Widgets_AllowNewsAndInterests] Registry AllowNewsAndInterests created and set to 0"
}


$registryPathGPO = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\{58C75E30-53B6-4D20-BB5A-ABA1B40F04A5}Machine\Software\Policies\Microsoft\Dsh"

# Check ONLY - if the GPO value is set to 0
$AllowNewsAndInterests = (Get-ItemProperty -Path $registryPathGPO -Name AllowNewsAndInterests).AllowNewsAndInterests
if ($AllowNewsAndInterests -ne 0) {

    Write-Host "[0390_Disable_Widgets_AllowNewsAndInterests] Group Policy Registry $registryPathGPO AllowNewsAndInterests NOT set to 0"
} else {
    Write-Host "[0390_Disable_Widgets_AllowNewsAndInterests] Group Policy Registry $registryPathGPO AllowNewsAndInterests is already set to 0"
}
