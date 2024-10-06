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
Set-ItemProperty -Path $desktopRegPath -Property @{
    "ScreenSaveActive"   = "1";    # Enable screen saver
    "ScreenSaveTimeOut"  = "900"   # Screen saver timeout (900 seconds)
    "ScreenSaverIsSecure"= "1";    # On resume, display logon screen
}

# Set property for PushNotifications (Optional)
# Uncomment the following lines to apply this setting
# Set-ItemProperty -Path $pushNotificationsRegPath -Name "NoToastApplicationNotificationOnLockScreen" -Value 1 -PropertyType DWord
# Write-Host "Turn off toast notifications on the lock screen setting applied."

# Output confirmation messages
Write-Host "Screen saver settings applied successfully."

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
