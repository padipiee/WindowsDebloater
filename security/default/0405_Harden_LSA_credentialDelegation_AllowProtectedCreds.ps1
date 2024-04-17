## 

# Function to set the registry value and display a message
$title = "[0405_Harden_LSA_credentialDelegation_AllowProtectedCreds]"
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
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"


# Use the function to set 'AllowProtectedCreds' to 1
Set-RegistryPolicy -Path $RegistryPath -Key "AllowProtectedCreds" -Value 1

# Output the current settings
Write-Host "$title Current configuration for 'AllowProtectedCreds':"
Get-ItemProperty -Path $RegistryPath -Name "AllowProtectedCreds"



# https://www.stigviewer.com/stig/windows_10/2019-09-25/finding/V-74699


#reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /v AllowProtectedCreds /t REG_DWORD /d 1 /f
#:;;; 18.8.4.2 (L1) Ensure 'Remote host allows delegation of non-exportable credentials' is set to 'Enabled'
#:[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation]
#:; <deleted> = (Default)
#:; 0000000 = Off
#:; 0000001 = On (CIS)
#:"AllowProtectedCreds"=dword:0000001
#
#
#:#Remote host allows delegation of non-exportable credentials
#:$indextest += 1
#:$chaine = $null
#:$traitement = $null
#:$exist = $null
#:$id = "CD" + "$indextest"
#:$chaine = "$indextest" + ";" + "(L1) Ensure 'Remote host allows delegation of non-exportable credentials' is set to 'Enabled', value must be 1 " + ";"
#:$exist = Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
#:if ( $exist -eq $true) {
#: $traitement = Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" |Select-Object AllowProtectedCreds
#: $traitement = $traitement.AllowProtectedCreds
#:}
#:else {
#: $traitement = "not configure"
#:}
#:
#:$chaine += $traitement
#:$chaine>> $nomfichier