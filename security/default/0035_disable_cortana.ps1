<#
.SYNOPSIS
This script disables Cortana and modifies related registry keys to restrict its functionality.

.DESCRIPTION
The script disables Cortana by modifying various registry keys. It sets the ExecutionPolicy to Unrestricted, creates or modifies registry keys related to Cortana and Windows Search, and sets their values to disable Cortana and restrict search functionality.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
.\0035_Disable_cortana.ps1
This command runs the script to disable Cortana and modify related registry keys.

.NOTES
Author: Unknown
Date: Unknown
Version: Unknown
#>
# Disable Cortana
Write-Host "[0035_Disable_cortana] Disabling Cortana"
#Activate ExecutionPolicy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;
#Get-ExecutionPolicy;

$Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
$Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
$Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"

if (!(Test-Path $Cortana1)) {
	New-Item $Cortana1
	Write-Host "[0035_Disable_cortana] key $Cortana1 added"
} else {
	Write-Host "[0035_Disable_cortana] key $Cortana1 already exists"
}

if ((Get-ItemProperty -Path $Cortana1 -Name AcceptedPrivacyPolicy).AcceptedPrivacyPolicy -ne 0) {
	Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
}

If (!(Test-Path $Cortana2)) {
	New-Item $Cortana2
	Write-Host "[0035_Disable_cortana] key $Cortana2 added"
}

if ((Get-ItemProperty -Path $Cortana2 -Name RestrictImplicitTextCollection).RestrictImplicitTextCollection -ne 1) {
	Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
	Write-Host "[0035_Disable_cortana] key $Cortana2 RestrictImplicitTextCollection set to 1"
}

if ((Get-ItemProperty -Path $Cortana2 -Name RestrictImplicitInkCollection).RestrictImplicitInkCollection -ne 1) {
	Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
	Write-Host "[0035_Disable_cortana] key $Cortana2 RestrictImplicitInkCollection set to 1"
}

If (!(Test-Path $Cortana3)) {
	New-Item $Cortana3
	Write-Host "[0035_Disable_cortana] key $Cortana3 added"
}

if ((Get-ItemProperty -Path $Cortana3 -Name HarvestContacts).HarvestContacts -ne 0) {
	Set-ItemProperty $Cortana3 HarvestContacts -Value 0
	Write-Host "[0035_Disable_cortana] key $Cortana3 HarvestContacts set to 0"
}

#########################
## Cortana and Search
#########################
$CortanaWindows_search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"

#Check presence of directory $CortanaWindows_search  and create it if needed
If (!(Test-Path $CortanaWindows_search)) {
	New-Item $CortanaWindows_search
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search created"
}

#Add or set keys
if ((Get-ItemProperty -Path $CortanaWindows_search -Name AllowCortana).AllowCortana -ne 0) {
	Set-ItemProperty $CortanaWindows_search AllowCortana -Value 0
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search AllowCortana set to 0"
}

if ((Get-ItemProperty -Path $CortanaWindows_search -Name AllowSearchToUseLocation).AllowSearchToUseLocation -ne 0) {
	Set-ItemProperty $CortanaWindows_search AllowSearchToUseLocation -Value 0
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search AllowSearchToUseLocation set to 0"
}

if ((Get-ItemProperty -Path $CortanaWindows_search -Name DisableWebSearch).DisableWebSearch -ne 1) {
	Set-ItemProperty $CortanaWindows_search DisableWebSearch -Value 1
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search DisableWebSearch set to 1"
}

if ((Get-ItemProperty -Path $CortanaWindows_search -Name ConnectedSearchUseWeb).ConnectedSearchUseWeb -ne 0) {
	Set-ItemProperty $CortanaWindows_search ConnectedSearchUseWeb -Value 0
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search ConnectedSearchUseWeb set to 0"
}

if ((Get-ItemProperty -Path $CortanaWindows_search -Name ConnectedSearchPrivacy).ConnectedSearchPrivacy -ne 3) {
	Set-ItemProperty $CortanaWindows_search ConnectedSearchPrivacy -Value 3
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search ConnectedSearchPrivacy set to 3"
}

if ((Get-ItemProperty -Path $Cortana2 -Name RestrictImplicitTextCollection).RestrictImplicitTextCollection -ne 1) {
	Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
	Write-Host "[0035_Disable_cortana] key  $Cortana2 RestrictImplicitTextCollection set to 1"
}

if ((Get-ItemProperty -Path $Cortana2 -Name RestrictImplicitInkCollection).RestrictImplicitInkCollection -ne 1) {
	Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
	Write-Host "[0035_Disable_cortana] key  $Cortana2 RestrictImplicitInkCollection set to 1"
}

If (!(Test-Path $Cortana3)) {
	New-Item $Cortana3
	Write-Host "[0035_Disable_cortana] key  $Cortana3 added"
}

if ((Get-ItemProperty -Path $Cortana3 -Name HarvestContacts).HarvestContacts -ne 0) {
	Set-ItemProperty $Cortana3 HarvestContacts -Value 0
	Write-Host "[0035_Disable_cortana] key  $Cortana3 HarvestContacts set to 0"
}

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
if (!(Test-Path $CortanaWindows_search)) {
	New-Item $CortanaWindows_search
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search added"
} else {
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search already exists"
}

#Add or set keys
$CortanaWindows_search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"

$AllowCortana = (Get-ItemProperty -Path $CortanaWindows_search -Name AllowCortana).AllowCortana
if ($AllowCortana -ne 0) {
	Set-ItemProperty $CortanaWindows_search AllowCortana -Value 0
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search AllowCortana set to 0"
} else {
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search AllowCortana already set to 0"
}

$AllowSearchToUseLocation = (Get-ItemProperty -Path $CortanaWindows_search -Name AllowSearchToUseLocation).AllowSearchToUseLocation
if ($AllowSearchToUseLocation -ne 0) {
	Set-ItemProperty $CortanaWindows_search AllowSearchToUseLocation -Value 0
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search AllowSearchToUseLocation set to 0"
} else {
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search AllowSearchToUseLocation already set to 0"
}

$DisableWebSearch = (Get-ItemProperty -Path $CortanaWindows_search -Name DisableWebSearch).DisableWebSearch
if ($DisableWebSearch -ne 1) {
	Set-ItemProperty $CortanaWindows_search DisableWebSearch -Value 1
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search DisableWebSearch set to 1"
} else {
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search DisableWebSearch already set to 1"
}

$ConnectedSearchUseWeb = (Get-ItemProperty -Path $CortanaWindows_search -Name ConnectedSearchUseWeb).ConnectedSearchUseWeb
if ($ConnectedSearchUseWeb -ne 0) {
	Set-ItemProperty $CortanaWindows_search ConnectedSearchUseWeb -Value 0
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search ConnectedSearchUseWeb set to 0"
} else {
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search ConnectedSearchUseWeb already set to 0"
}

$ConnectedSearchPrivacy = (Get-ItemProperty -Path $CortanaWindows_search -Name ConnectedSearchPrivacy).ConnectedSearchPrivacy
if ($ConnectedSearchPrivacy -ne 3) {
	Set-ItemProperty $CortanaWindows_search ConnectedSearchPrivacy -Value 3
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search ConnectedSearchPrivacy set to 3"
} else {
	Write-Host "[0035_Disable_cortana] key $CortanaWindows_search ConnectedSearchPrivacy already set to 3"
}

