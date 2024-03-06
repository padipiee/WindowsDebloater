# Define the registry path
$registryPath = "HKCU:\Software\Policies\BraveSoftware\Brave"

# Check if the registry key exists
if (!(Test-Path -Path $registryPath)) {
    # If the registry key does not exist, create it
    New-Item -Path $registryPath -Force | Out-Null
}

# Check if the AutofillEnabled value is not already set to 0
$autofillEnabled = (Get-ItemProperty -Path $registryPath -Name AutofillEnabled).AutofillEnabled
if ($autofillEnabled -ne 0) {
    # Set the AutofillEnabled value to 0 to disable autofill
    Set-ItemProperty -Path $registryPath -Name AutofillEnabled -Value 0
    Write-Host "[0389_Disable_Brave_save_fill] Registry AutofillEnabled set to 0"
} else {
    Write-Host "[0389_Disable_Brave_save_fill] Registry AutofillEnabled is already set to 0"
}

# Check if the PasswordManagerEnabled value is not already set to 0
$passwordManagerEnabled = (Get-ItemProperty -Path $registryPath -Name PasswordManagerEnabled).PasswordManagerEnabled
if ($passwordManagerEnabled -ne 0) {
    # Set the PasswordManagerEnabled value to 0 to disable password manager
    Set-ItemProperty -Path $registryPath -Name PasswordManagerEnabled -Value 0
    Write-Host "[0389_Disable_Brave_save_fill] Registry PasswordManagerEnabled set to 0"
} else {
    Write-Host "[0389_Disable_Brave_save_fill] Registry PasswordManagerEnabled is already set to 0"
}



#Specific to the Brave browser and are not part of the Chromium project.
# Therefore, these settings cannot be modified via the Windows Registry :
# via $prefs = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Preferences"

# "autofill_profiles":  false,
# "autofill_wallet":  false,
# "autofill_wallet_credential":  false,
# "autofill_wallet_metadata":  false,
# "autofill_wallet_offer":  false,
# "autofill_wallet_usage":  false,


# "data_type_status_for_sync_to_signin":  {
#     "app_list":  false,
#     "app_settings":  false,
#     "apps":  false,
#     "arc_package":  false,
#     "autofill":  false,
#     "autofill_profiles":  false,
#     "autofill_wallet":  false,
#     "autofill_wallet_credential":  false,
#     "autofill_wallet_metadata":  false,
#     "autofill_wallet_offer":  false,
#     "autofill_wallet_usage":  false,
#     "bookmarks":  false,
#     "contact_info":  false,
#     "device_info":  false,
#     "dictionary":  false,
#     "extension_settings":  false,
#     "extensions":  false,
#     "history":  false,
#     "history_delete_directives":  false,
#     "incoming_password_sharing_invitation":  false,
#     "managed_user_settings":  false,
#     "nigori":  false,
#     "os_preferences":  false,
#     "os_priority_preferences":  false,
#     "outgoing_password_sharing_invitation":  false,
#     "passwords":  false,
#     "power_bookmark":  false,
#     "preferences":  false,
#     "printers":  false,
#     "printers_authorization_servers":  false,
#     "priority_preferences":  false,
#     "reading_list":  false,
#     "saved_tab_group":  false,
#     "search_engines":  false,
#     "security_events":  false,
#     "segmentation":  false,
#     "send_tab_to_self":  false,
#     "sessions":  false,
#     "sharing_message":  false,
#     "themes":  false,
#     "user_consent":  false,
#     "user_events":  false,
#     "web_apps":  false,
#     "webauthn_credential":  false,
#     "wifi_configurations":  false,
#     "workspace_desk":  false
# },