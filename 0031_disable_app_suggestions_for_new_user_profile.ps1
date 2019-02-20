#disable app suggestions for new user profile
#set-executionpolicy unrestricted
#reg load HKU\Default_User C:\Users\Default\NTUSER.DAT
#Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SystemPaneSuggestionsEnabled -Value 0
#reg unload HKU\Default_User

Get-ExecutionPolicy;