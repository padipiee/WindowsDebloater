
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

function Remove-Package($name) {  
  $key = "SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\$name"
  Take-Over $key
  Remove-Item -Path HKLM:"$key\Owners" -Force -Recurse
  & C:\Windows\System32\PkgMgr.exe /up:$name /norestart /quiet
}

#Remove Feedback
$packageBase = "Microsoft-WindowsFeedback"
$packageNames = (dir ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\" + $packageBase + "*")).name

forEach ($package in $packageNames)
{   
    Remove-Package $package.substring($package.indexOf($packageBase))
}