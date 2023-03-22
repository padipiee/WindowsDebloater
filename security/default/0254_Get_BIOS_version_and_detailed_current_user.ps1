
# 0254_Get_BIOS_version_and_detailed_current_user
#BIOS Version
Get-WmiObject Win32_BIOS


#SMBIOSBIOSVersion : V1.x
#Manufacturer      : x
#Name              : x
#SerialNumber      : x
#Version           : x

#Check if it is virtualized
Get-WmiObject Win32_BIOS -Filter 'SerialNumber LIKE "%VMware%"'


#Connected user
(gwmi -class win32_computerSystem).username


#PowerShell session runs under a particular security context, so if what you are trying to achieve is to get the corresponding account you can use this
[System.Security.Principal.WindowsIdentity]::GetCurrent()

#AuthenticationType : NTLM
#ImpersonationLevel : None
#IsAuthenticated    : True
#IsGuest            : False
#IsSystem           : False
#IsAnonymous        : False
#Name               :
#Owner              :
#User               :
#Groups             :
#Token              :
#AccessToken        :
#UserClaims         :
#DeviceClaims       :
#Claims             :
#                    
#Actor              :
#BootstrapContext   :
#Label              :
#NameClaimType      :
#RoleClaimType      :