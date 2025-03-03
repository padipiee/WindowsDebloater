# Define registry paths
$desktopRegPath = "HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop"
$pushNotificationsRegPath = "HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"

# Ensure the registry paths exist
foreach ($path in @($desktopRegPath, $pushNotificationsRegPath)) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }
}

# Set multiple properties for Desktop
$desiredValues = @{
    "ScreenSaveActive"   = "1"
    "ScreenSaveTimeOut"  = "900"
    "ScreenSaverIsSecure"= "1"
}
foreach ($item in $desiredValues.Keys) {
    $currentValue = (Get-ItemProperty -Path $desktopRegPath -Name $item -ErrorAction SilentlyContinue).$item
    if ($currentValue -ne $desiredValues[$item]) {
        Set-ItemProperty -Path $desktopRegPath -Name $item -Value $desiredValues[$item]
        Write-Host "$item set to $($desiredValues[$item])."
    } else {
        Write-Host "$item is already $($desiredValues[$item])."
    }
}

# Set property for PushNotifications (Optional)
# Uncomment the following lines to apply this setting
# Set-ItemProperty -Path $pushNotificationsRegPath -Name "NoToastApplicationNotificationOnLockScreen" -Value 1 -PropertyType DWord
# Write-Host "Turn off toast notifications on the lock screen setting applied."


#reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure /t REG_SZ /d 1 /f


#;;; 19.1.3.2 (L1) Ensure 'Force specific screen saver: Screen saver executable name' is set to 'Enabled: scrnsave.scr'
#[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop]
#; <deleted> = (Default)
#; scrnsave.scr = On (CIS)
#"SCRNSAVE.EXE"="scrnsave.scr"

# # 19.1.3.1 (L1) Ensure 'Enable screen saver' is set to 'Enabled'
# Registry 'ScreenSaveActive' {
#     Ensure    = 'Present'
#     Key       = 'HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop'
#     ValueName = 'ScreenSaveActive'
#     ValueType = 'String'
#     ValueData = '1'
# }
