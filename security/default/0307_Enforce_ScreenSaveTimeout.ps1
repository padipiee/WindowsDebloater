
# :: Enforce screen locking
# :: https://www.stigviewer.com/stig/windows_server_20122012_r2_domain_controller/2017-06-09/finding/V-36773
# :: https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit


# Set the desired delay value in seconds
$delaySeconds = 900

# Check if the registry path exists
if (Test-Path -Path "HKCU:\Control Panel\Desktop") {
    $existingValue = (Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -ErrorAction SilentlyContinue).ScreenSaveTimeOut
    Write-Host "Existing value of ScreenSaveTimeOut: $existingValue"

    # Check if the existing value is not already set to the target value
    if ($existingValue -ne $delaySeconds.ToString()) {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Value $delaySeconds.ToString() -Type String -Force
        Write-Host "ScreenSaveTimeOut has been set to $delaySeconds seconds."
    } else {
        Write-Host "ScreenSaveTimeOut is already set to $delaySeconds seconds."
    }
} else {
    Write-Host "Registry path 'HKCU:\Control Panel\Desktop' not found."
}
  

#       @REM # 19.1.3.4 (L1) Ensure 'Screen saver timeout' is set to 'Enabled: 900 seconds or fewer, but not 0'
#       @REM Registry 'ScreenSaveTimeOut' {
#       @REM     Ensure       = 'Present'
#       @REM     Key          = 'HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop'
#       @REM     ValueName    = 'ScreenSaveTimeOut'
#       @REM     ValueType    = 'DWord'
#       @REM     ValueData    = '900'
#       @REM }

# rem Specifies in seconds how long the System remains idle before the screen saver starts
# reg query "HKCU\Control Panel\Desktop"
# reg add "HKCU\Control Panel\Desktop" /v "ScreenSaveTimeOut" /t REG_SZ /d "900" /f