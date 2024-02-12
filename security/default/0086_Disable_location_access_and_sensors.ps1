$locationKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"
$disableLocation = 1
$disableLocationScripting = 1
$disableSensors = 1
$disableWindowsLocationProvider = 1

if (Test-Path $locationKeyPath) {
    $currentDisableLocation = Get-ItemPropertyValue -Path $locationKeyPath -Name "DisableLocation" -ErrorAction SilentlyContinue
    $currentDisableLocationScripting = Get-ItemPropertyValue -Path $locationKeyPath -Name "DisableLocationScripting" -ErrorAction SilentlyContinue
    $currentDisableSensors = Get-ItemPropertyValue -Path $locationKeyPath -Name "DisableSensors" -ErrorAction SilentlyContinue
    $currentDisableWindowsLocationProvider = Get-ItemPropertyValue -Path $locationKeyPath -Name "DisableWindowsLocationProvider" -ErrorAction SilentlyContinue

    if ($currentDisableLocation -eq $disableLocation) {
        Write-Host "[0086_Disable_location_access_and_sensors] DisableLocation is already set to $disableLocation"
    } else {
        Set-ItemProperty -Path $locationKeyPath -Name "DisableLocation" -Value $disableLocation
        Write-Host "[0086_Disable_location_access_and_sensors] DisableLocation has been set to $disableLocation"
    }

    if ($currentDisableLocationScripting -eq $disableLocationScripting) {
        Write-Host "[0086_Disable_location_access_and_sensors] DisableLocationScripting is already set to $disableLocationScripting"
    } else {
        Set-ItemProperty -Path $locationKeyPath -Name "DisableLocationScripting" -Value $disableLocationScripting
        Write-Host "[0086_Disable_location_access_and_sensors] DisableLocationScripting has been set to $disableLocationScripting"
    }

    if ($currentDisableSensors -eq $disableSensors) {
        Write-Host "[0086_Disable_location_access_and_sensors] DisableSensors is already set to $disableSensors"
    } else {
        Set-ItemProperty -Path $locationKeyPath -Name "DisableSensors" -Value $disableSensors
        Write-Host "[0086_Disable_location_access_and_sensors] DisableSensors has been set to $disableSensors"
    }

    if ($currentDisableWindowsLocationProvider -eq $disableWindowsLocationProvider) {
        Write-Host "[0086_Disable_location_access_and_sensors] DisableWindowsLocationProvider is already set to $disableWindowsLocationProvider"
    } else {
        Set-ItemProperty -Path $locationKeyPath -Name "DisableWindowsLocationProvider" -Value $disableWindowsLocationProvider
        Write-Host "[0086_Disable_location_access_and_sensors] DisableWindowsLocationProvider has been set to $disableWindowsLocationProvider"
    }
} else {
    Write-Host "[0086_Disable_location_access_and_sensors] LocationAndSensors key does not exist"
}
