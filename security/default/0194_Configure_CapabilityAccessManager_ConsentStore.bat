
:::::::NOT ACTIVATED TO keep usability (videoconference...etc)
:: App access turn off camera
::REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access microphone
::REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /d Deny /t REG_SZ /f


::::::::DENY ACTIVATED
:: Disable app diag info about your other apps
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v Value /d Deny /t REG_SZ /f
:: do not allow apps to access your file system
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v Value /d Deny /t REG_SZ /f
:: do not allow apps to access your contacts
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access Notifications
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access Account Information
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access calendar
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access call history
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v Value /d Deny /t REG_SZ /f
:: Do not Allow apps to access email 
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access tasks
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v Value /d Deny /t REG_SZ /f
:: Do not allow apps to access messaging
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v Value /d Deny /t REG_SZ /f
:: Do Not allow apps to access radio
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v Value /d Deny /t REG_SZ /f
:: do not allow apps to access other devices
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v Value /d Deny /t REG_SZ /f
:: do not allow apps to access Documents
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v Value /d Deny /t REG_SZ /f
:: do not allow apps to access Pictures
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v Value /d Deny /t REG_SZ /f
:: do not allow apps to access Videos
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v Value /d Deny /t REG_SZ /f


