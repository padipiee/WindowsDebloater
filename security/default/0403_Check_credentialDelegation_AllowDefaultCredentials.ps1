
# https://thegeekpage.com/credssp-encryption-oracle-remediation-error/
# https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.CredentialsSSP::AllowDefaultCredentials
# Check the CredSSP registry key - Allow delegating default credentials (general and NTLM)


$Path = "HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation"
$Name = "AllowDefaultCredentials"
$title = "[0403_Check_credentialDelegation_AllowDefaultCredentials]"

$reg = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop
if($null -eq $reg){
    Write-Host "$title Not allowing delegation of default credentials - No configuration found default setting is set to false"
} else {
    Write-Host "$title !! allowing delegation of default credentials"
}

