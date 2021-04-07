Auditpol /set /category:"Account Logon" /Success:enable /failure:enable
Auditpol /set /category:"Logon/Logoff" /Success:enable /failure:enable
Auditpol /set /category:"Account Management" /Success:enable /failure:enable
Auditpol /set /category:"DS Access" /failure:enable
Auditpol /set /category:"Object Access" /failure:enable
Auditpol /set /category:"policy change" /Success:enable /failure:enable
Auditpol /set /category:"Privilege use" /Success:enable /failure:enable
Auditpol /set /category:"System" /failure:enable