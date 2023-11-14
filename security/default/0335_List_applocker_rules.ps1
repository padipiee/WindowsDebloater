<#
.SYNOPSIS
Retrieves the AppLocker policy and selects the RuleCollections property.

.DESCRIPTION
This command retrieves the effective AppLocker policy and selects the RuleCollections property. 
The RuleCollections property contains the list of rule collections that are part of the policy.

.EXAMPLE
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
#>
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections