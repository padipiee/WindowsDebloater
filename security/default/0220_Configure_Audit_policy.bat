:: ref 0342

auditpol /get /category:*
::
:: Enable Windows Event Detailed Logging
:: This is intentionally meant to be a subset of expected enterprise logging as this script may be used on consumer devices.
:: For more extensive Windows logging, I recommend https://www.malwarearchaeology.com/cheat-sheets

auditpol /set /category:"Account Logon" /Success:enable /failure:enable
auditpol /set /category:"Logon/Logoff" /Success:enable /failure:enable
auditpol /set /category:"Account Management" /Success:enable /failure:enable
auditpol /set /category:"DS Access" /failure:enable
auditpol /set /category:"Object Access" /failure:enable
auditpol /set /category:"policy change" /Success:enable /failure:enable
auditpol /set /category:"Privilege use" /Success:enable /failure:enable
auditpol /set /category:"System" /failure:enable

auditpol /set /subcategory:"Security Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable
auditpol /set /subcategory:"Logoff" /success:enable /failure:disable
auditpol /set /subcategory:"Logon" /success:enable /failure:enable 
:: auditpol /set /subcategory:"Filtering Platform Connection" /success:enable /failure:disable
auditpol /set /subcategory:"Removable Storage" /success:enable /failure:enable
auditpol /set /subcategory:"SAM" /success:disable /failure:disable
auditpol /set /subcategory:"Filtering Platform Policy Change" /success:disable /failure:disable
:: auditpol /set /subcategory:"IPsec Driver" /success:enable /failure:enable
auditpol /set /subcategory:"Security State Change" /success:enable /failure:enable
auditpol /set /subcategory:"Security System Extension" /success:enable /failure:enable
auditpol /set /subcategory:"System Integrity" /success:enable /failure:enable