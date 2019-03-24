# Disable Cortana
Write-Host "Disabling Cortana"
#Activate ExecutionPolicy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;
Get-ExecutionPolicy;

$Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
$Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
$Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"


If (!(Test-Path $Cortana1)) {
	New-Item $Cortana1
}

Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
If (!(Test-Path $Cortana2)) {
	New-Item $Cortana2
}

Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 

If (!(Test-Path $Cortana3)) {
	New-Item $Cortana3
}
Set-ItemProperty $Cortana3 HarvestContacts -Value 0

#########################
## Cortana and Search
#########################
#AllowCortana : Choose whether to let Cortana install and run on the device. Disable this policy to turn off Cortana.
#AllowSearchToUseLocation : Choose whether Cortana and Search can provide location-aware search results. 
#  Disable this policy to block access to location information for Cortana.
#DisableWebSearch : Choose whether to search the web from Windows Desktop Search.
#  Enable this policy to remove the option to search the Internet from Cortana.
#ConnectedSearchUseWeb : Choose whether to search the web from Cortana. 
#  Enable this policy to stop web queries and results from showing in Search.
#ConnectedSearchPrivacy : Control what information is shared with Bing in Search. 
#   If you enable this policy and set it to Anonymous info, usage information will be shared but not search history,
#   Microsoft Account information, or specific location.
#########################

$CortanaWindows_search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"

#Check presence of directory $CortanaWindows_search  and create it if needed
If (!(Test-Path $CortanaWindows_search)) {
    New-Item $CortanaWindows_search
}

#Add or set keys
Set-ItemProperty $CortanaWindows_search AllowCortana -Value 0
Set-ItemProperty $CortanaWindows_search AllowSearchToUseLocation -Value 0
Set-ItemProperty $CortanaWindows_search DisableWebSearch -Value 1
Set-ItemProperty $CortanaWindows_search ConnectedSearchUseWeb -Value 0
Set-ItemProperty $CortanaWindows_search ConnectedSearchPrivacy -Value 3


