
Disable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
Disable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

##
Disable-WindowsOptionalFeature -Online -FeatureName FaxServicesClientPackage





#Dism /online /Get-Features
#Dism /Online /Disable-Feature /FeatureName:FaxServicesClientPackage /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64
#Dism /Online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:MSRDC-Infrastructure /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:Printing-Foundation-Features /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:Printing-XPSServices-Features /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:SearchEngine-Client-Package /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:WCF-TCP-PortSharing45 /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:MediaPlayback /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:WorkFolders-Client /Quiet /NoRestart
#Dism /Online /Disable-Feature /FeatureName:Xps-Foundation-Xps-Viewer /Quiet /NoRestart
#dism.exe /Online /Disable-Feature:HypervisorPlatform

#Feature Name : Microsoft-Windows-Subsystem-Linux
#State : Disabled
#
#Feature Name : HypervisorPlatform
#State : Disabled
#
#Feature Name : VirtualMachinePlatform
#State : Enabled