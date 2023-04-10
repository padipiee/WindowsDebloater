
#:: Enable smartscreen
#::https://www.maketecheasier.com/disable-smartscreen-filter-windows10/
#:: https://www.winhelponline.com/blog/bypass-smartscreen-even-if-its-enabled-through-group-policy/
#::Keeping the SmartScreen “always-on” is advisable, as it’s the easiest way to protect your device from undetectable threats
#:: Disable 0075


function Set-SmartScreen {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
    $valueName = "EnableSmartScreen"

    # Prompt user for action
    $action = Read-Host "Enter action (Enable/Disable):"
    $action = $action.Trim().ToLower()

    if ($action -eq "enable") {
        # Set EnableSmartScreen value to 1 to enable SmartScreen
        Set-ItemProperty -Path $regPath -Name $valueName -Value 1 -Force
        Write-Output "SmartScreen has been enabled."
    } elseif ($action -eq "disable") {
        # Set EnableSmartScreen value to 0 to disable SmartScreen
        Set-ItemProperty -Path $regPath -Name $valueName -Value 0 -Force
        Write-Output "SmartScreen has been disabled."
    } else {
        Write-Error "Invalid action. Please specify 'Enable' or 'Disable'."
    }

    # Display the current value of EnableSmartScreen
    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName
    Write-Output "Current value of EnableSmartScreen: $currentValue"
}


Set-SmartScreen
