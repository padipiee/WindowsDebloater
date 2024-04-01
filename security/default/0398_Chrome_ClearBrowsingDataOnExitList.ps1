# PowerShell Script to Check and Set Chrome ClearBrowsingDataOnExitList Policy

# Define the base path for Chrome policies in the registry
$chromePolicyPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\ClearBrowsingDataOnExitList"

# Ensure the policy path exists
If (-not (Test-Path $chromePolicyPath)) {
    New-Item -Path $chromePolicyPath -Force | Out-Null
    Write-Output "[0398_Chrome_ClearBrowsingDataOnExitList] Policy path created."
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
    $currentValue = Get-ItemProperty -Path $chromePolicyPath -Name $item.Key -ErrorAction SilentlyContinue
    If ($null -eq $currentValue) {
        # Property does not exist, add it
        Set-ItemProperty -Path $chromePolicyPath -Name $item.Key -Value $item.Value
        Write-Output "[0398_Chrome_ClearBrowsingDataOnExitList] Item $($item.Key) added with value '$($item.Value)'."
    }
    elseif ($currentValue.$($item.Key) -ne $item.Value) {
        # Property exists but needs to be updated
        Set-ItemProperty -Path $chromePolicyPath -Name $item.Key -Value $item.Value
        Write-Output "[0398_Chrome_ClearBrowsingDataOnExitList] Item $($item.Key) updated to value '$($item.Value)'."
    }
    else {
        # Property already exists with the desired value
        Write-Output "[0398_Chrome_ClearBrowsingDataOnExitList] Item $($item.Key) is already set to the target value."
    }
}
