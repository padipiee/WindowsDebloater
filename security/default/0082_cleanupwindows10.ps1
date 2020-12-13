# Clean removal of system apps (bypass error 0x80073CFA)
# Adaptations from https://github.com/10se1ucgo/DisableWinTracking/issues/48
# https://github.com/10se1ucgo/DisableWinTracking/issues/48
# for Applications "That can not be deleted...""
# REF : https://answers.microsoft.com/en-us/insider/forum/all/how-to-uninstall-windows-feedback-app-on-windows/92b029c5-cc9d-4cf7-8ae4-7a979d95d81d


##########Usage############
# [1] You can change the variable $packageBase at the end of the script to different package names.
# [2] extra> PowerShell.exe -ExecutionPolicy Bypass -File .\cleanupwindows10.ps1
# Does not work on any applications... (like Cortana that have other hooks)
####################

function Enable-Privilege {  
  param($Privilege)
  $Definition = @'
using System;  
using System.Runtime.InteropServices;  
public class AdjPriv {  
  [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
  internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall,
    ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr rele);
  [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
  internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr phtok);
  [DllImport("advapi32.dll", SetLastError = true)]
  internal static extern bool LookupPrivilegeValue(string host, string name,
    ref long pluid);
  [StructLayout(LayoutKind.Sequential, Pack = 1)]
  internal struct TokPriv1Luid {
    public int Count;
    public long Luid;
    public int Attr;
  }
  internal const int SE_PRIVILEGE_ENABLED = 0x00000002;
  internal const int TOKEN_QUERY = 0x00000008;
  internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;
  public static bool EnablePrivilege(long processHandle, string privilege) {
    bool retVal;
    TokPriv1Luid tp;
    IntPtr hproc = new IntPtr(processHandle);
    IntPtr htok = IntPtr.Zero;
    retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY,
      ref htok);
    tp.Count = 1;
    tp.Luid = 0;
    tp.Attr = SE_PRIVILEGE_ENABLED;
    retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
    retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero,
      IntPtr.Zero);
    return retVal;
  }
}
'@  
  $ProcessHandle = (Get-Process -id $pid).Handle
  $type = Add-Type $definition -PassThru
  $type[0]::EnablePrivilege($processHandle, $Privilege)
}

function Take-Over($path) {  
  $owner = [Security.Principal.NTAccount]'Administrators'

  $key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($path, 'ReadWriteSubTree', 'TakeOwnership')
  $acl = $key.GetAccessControl()
  $acl.SetOwner($owner)
  $key.SetAccessControl($acl)

  $acl = $key.getaccesscontrol()
  $rule = New-Object System.Security.AccessControl.RegistryAccessRule "Administrators", "FullControl", "ContainerInherit", "None", "Allow"
  $acl.SetAccessRule($rule)
  $key.SetAccessControl($acl)
}

do {} until (Enable-Privilege SeTakeOwnershipPrivilege)

#TODO replace PkgMgre.exe by DISM.exe
#Deployment Image Servicing and Management (DISM.exe) 
#Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages
function Remove-Package($name) {  
  $key = "SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\$name"
  Take-Over $key
  Remove-Item -Path HKLM:"$key\Owners" -Force -Recurse
  & C:\Windows\System32\PkgMgr.exe /up:$name /norestart /quiet
}



#List Miscrosoft pakac
Write-Output "List Miscrosoft packages in CurrentVersion\Component Based Servicing\Packages"
$packageBase = "Microsoft-WindowsFeedback"
$packageNames = (dir ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\" + $packageBase + "*")).name

forEach ($package in $packageNames)
{   
    Write-Output  $package.substring($package.indexOf($packageBase))  found
}


#Remove Feedback
Write-Output "!!!!!!!If exist attempt to remove Microsoft-WindowsFeedback "
$packageBase = "Microsoft-WindowsFeedback"
$packageNames = (dir ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\" + $packageBase + "*")).name

forEach ($package in $packageNames)
{   
    Remove-Package $package.substring($package.indexOf($packageBase))
}