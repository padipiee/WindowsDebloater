# PowerShell Script to Check and Set Brave ClearBrowsingDataOnExitList Policy

# Define the base path for Chrome policies in the registry
$BravePolicyPath = "HKCU:\Software\Policies\BraveSoftware\Brave\ClearBrowsingDataOnExitList"


# Ensure the policy path exists
If (-not (Test-Path $BravePolicyPath)) {
    New-Item -Path $BravePolicyPath -Force | Out-Null
    Write-Output "[0399_Brave_ClearBrowsingDataOnExitList] Policy path created."
}

# Define the data to clear on exit
$dataToClear = @{
    "1" = "browsing_history"
    "2" = "download_history"
    "3" = "cookies_and_other_site_data"
    "4" = "cached_images_and_files"
    "5" = "password_signin"
    "6" = "autofill"
    "7" = "site_settings"
    "8" = "hosted_app_data"
}

# Apply the policy settings
foreach ($item in $dataToClear.GetEnumerator()) {
    $currentValue = Get-ItemProperty -Path $BravePolicyPath -Name $item.Key -ErrorAction SilentlyContinue
    If ($null -eq $currentValue) {
        # Property does not exist, add it
        Set-ItemProperty -Path $BravePolicyPath -Name $item.Key -Value $item.Value
        Write-Output "[0399_Brave_ClearBrowsingDataOnExitList] Item $($item.Key) added with value '$($item.Value)'."
    }
    elseif ($currentValue.$($item.Key) -ne $item.Value) {
        # Property exists but needs to be updated
        Set-ItemProperty -Path $BravePolicyPath -Name $item.Key -Value $item.Value
        Write-Output "[0399_Brave_ClearBrowsingDataOnExitList] Item $($item.Key) updated to value '$($item.Value)'."
    }
    else {
        # Property already exists with the desired value
        Write-Output "[0399_Brave_ClearBrowsingDataOnExitList] Item $($item.Key) is already set to the target value."
    }
}
