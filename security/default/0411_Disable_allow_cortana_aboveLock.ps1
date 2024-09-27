Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" |Select-Object AllowCortanaAboveLock

#Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\AboveLock\AllowCortanaAboveLock
# https://admx.help/?Category=Windows_10_2016&Policy=FullArmor.Policies.3B9EA2B5_A1D1_4CD5_9EDE_75B22990BC21::AllowCortanaAboveLock


# ;;; 18.9.60.4 (L1) Ensure 'Allow Cortana above lock screen' is set to 'Disabled'
# ;[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
# ; <deleted> = (Default)
# ; 0000000 = Off (CIS)
# ; 0000001 = On
# ; NON-COMPLIANCE TO NOT DISRUPT COMMON HOME FEATURES
# ;"AllowCortanaAboveLock"=dword:0000000


## 

# Function to set the registry value and display a message
$title = "[0411_Disable_allow_cortana_aboveLock]"
Function Set-RegistryPolicy {
    param (
        [string]$Path,
        [string]$Key,
        [int]$Value
    )
    # Ensure the registry path exists
    If (-Not (Test-Path $Path)) {
        # Create the registry path if it does not exist
        New-Item -Path $Path -Force
        Write-Host "$title Registry path '$Path' did not exist. It has been created."
    }

    # Check if the registry key exists
    If ($null -ne (Get-ItemProperty -Path $Path -Name $Key -ErrorAction SilentlyContinue)) {
        # If it exists, set the value
        Set-ItemProperty -Path $Path -Name $Key -Value $Value
        Write-Host "$title The key '$Key' was already set. It has been reconfirmed with the new value."
    } else {
        # If it does not exist, create it and set the value
        New-ItemProperty -Path $Path -Name $Key -Value $Value -PropertyType DWORD
        Write-Host "$title he key '$Key' did not exist. It has been created and set with the value."
    }
}

# Define the registry path for the policy
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"


# Use the function to set 'AllowProtectedCreds' to 1
Set-RegistryPolicy -Path $RegistryPath -Key "AllowCortanaAboveLock" -Value 0