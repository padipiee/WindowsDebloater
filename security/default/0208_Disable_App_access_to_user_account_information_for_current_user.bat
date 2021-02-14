::Disable app access to user account information for current user
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /d "Deny" /t REG_SZ /f 
:: Deny = Off
::Allow = On