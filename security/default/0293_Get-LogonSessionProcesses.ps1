if (-not ('TokenInformation.ProcessNativeMethods' -as [type])){
  $TypeDef = @'
using System;
using System.Runtime.InteropServices;
namespace TokenInformation {
   [Flags]
   public enum ProcessAccess {
       All = 0x001FFFFF,
       Terminate = 0x00000001,
       CreateThread = 0x00000002,
       VirtualMemoryOperation = 0x00000008,
       VirtualMemoryRead = 0x00000010,
       VirtualMemoryWrite = 0x00000020,
       DuplicateHandle = 0x00000040,
       CreateProcess = 0x000000080,
       SetQuota = 0x00000100,
       SetInformation = 0x00000200,
       QueryInformation = 0x00000400,
       QueryLimitedInformation = 0x00001000,
       Synchronize = 0x00100000
   }

   [Flags]
   public enum ThreadAccess {
           TERMINATE           = (0x0001),
           SUSPEND_RESUME      = (0x0002),
           GET_CONTEXT         = (0x0008),
           SET_CONTEXT         = (0x0010),
           SET_INFORMATION     = (0x0020),
           QUERY_INFORMATION       = (0x0040),
           QUERY_LIMITED           = (0x00000800),
           SET_THREAD_TOKEN    = (0x0080),
           IMPERSONATE         = (0x0100),
           DIRECT_IMPERSONATION    = (0x0200)
       }

  [Flags]
   public enum TokenAccess {
       STANDARD_RIGHTS_REQUIRED = 0x000F0000,
       STANDARD_RIGHTS_READ = 0x00020000,
       TOKEN_ASSIGN_PRIMARY = 0x0001,
       TOKEN_DUPLICATE = 0x0002,
       TOKEN_IMPERSONATE = 0x0004,
       TOKEN_QUERY = 0x0008,
       TOKEN_QUERY_SOURCE = 0x0010,
       TOKEN_ADJUST_PRIVILEGES = 0x0020,
       TOKEN_ADJUST_GROUPS = 0x0040,
       TOKEN_ADJUST_DEFAULT = 0x0080,
       TOKEN_ADJUST_SESSIONID = 0x0100,
       TOKEN_IMPERSONATEUSER = (TOKEN_DUPLICATE | TOKEN_QUERY),
       TOKEN_READ = (STANDARD_RIGHTS_READ | TOKEN_QUERY),
       TOKEN_QUERY_ALL = (TOKEN_QUERY | TOKEN_QUERY_SOURCE),
       TOKEN_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED | TOKEN_ASSIGN_PRIMARY |
           TOKEN_DUPLICATE | TOKEN_IMPERSONATE | TOKEN_QUERY | TOKEN_QUERY_SOURCE |
           TOKEN_ADJUST_PRIVILEGES | TOKEN_ADJUST_GROUPS | TOKEN_ADJUST_DEFAULT |
           TOKEN_ADJUST_SESSIONID)
   }

  [Flags]
   public enum TOKEN_INFORMATION_CLASS {
      TokenUser = 1,
      TokenGroups,
      TokenPrivileges,
      TokenOwner,
      TokenPrimaryGroup,
      TokenDefaultDacl,
      TokenSource,
      TokenType,
      TokenImpersonationLevel,
      TokenStatistics,
      TokenRestrictedSids,
      TokenSessionId,
      TokenGroupsAndPrivileges,
      TokenSessionReference,
      TokenSandBoxInert,
      TokenAuditPolicy,
      TokenOrigin,
      TokenElevationType,
      TokenLinkedToken,
      TokenElevation,
      TokenHasRestrictions,
      TokenAccessInformation,
      TokenVirtualizationAllowed,
      TokenVirtualizationEnabled,
      TokenIntegrityLevel,
      TokenUIAccess,
      TokenMandatoryPolicy,
      TokenLogonSid,
      MaxTokenInfoClass
   }

   public enum SECURITY_IMPERSONATION_LEVEL {
       SecurityAnonymous,
       SecurityIdentification,
       SecurityImpersonation,
       SecurityDelegation
   }

  [Flags]
   public enum TOKEN_TYPE {
       TokenPrimary = 1,
       TokenImpersonation = 2
   }

   [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
       public struct TOKEN_STATISTICS {
           public LUID   TokenId;
           public LUID   AuthenticationId;
           public long   ExpirationTime;
           public uint   TokenType;
           public uint   ImpersonationLevel;
           public uint   DynamicCharged;
           public uint   DynamicAvailable;
           public uint   GroupCount;
           public uint   PrivilegeCount;
           public LUID   ModifiedId;
       }

   public struct TOKEN_USER
       {
           public SID_AND_ATTRIBUTES User ;
       }

   public struct TOKEN_LINKED_TOKEN
       {
           public IntPtr LinkedToken ;
       }

   public struct TOKEN_OWNER
   {
       public IntPtr Sid ;
   }

   [StructLayout(LayoutKind.Sequential)]
   public struct SID_AND_ATTRIBUTES
       {

           public IntPtr Sid ;
           public int Attributes ;
       }
   
   [StructLayout(LayoutKind.Sequential)]
   public struct LUID
       {
           public UInt32 LowPart;
           public Int32 HighPart;
       }

   [StructLayout(LayoutKind.Sequential)]
   public struct TOKEN_ORIGIN {
       public LUID OriginatingLogonSession ;
   }

   [StructLayout(LayoutKind.Sequential)]
   public struct TOKEN_MANDATORY_LABEL {
       public SID_AND_ATTRIBUTES Label ;
   }

   public class ProcessNativeMethods {
       [DllImport("kernel32.dll", SetLastError = true)]
       public static extern IntPtr OpenProcess(
           int processAccess,
           bool bInheritHandle,
           int processId);

       [DllImport("advapi32.dll", SetLastError=true)]
       public static extern bool OpenProcessToken(
           IntPtr ProcessHandle,
           uint DesiredAccess, 
           ref IntPtr TokenHandle);
       
       [DllImport("advapi32.dll", SetLastError=true)]
       public static extern bool GetTokenInformation(
           IntPtr TokenHandle,
           TOKEN_INFORMATION_CLASS TokenInformationClass,
           IntPtr TokenInformation,
           uint TokenInformationLength,
           ref uint ReturnLength);

       [DllImport("advapi32", CharSet = CharSet.Auto, SetLastError = true)]
       public static extern bool ConvertSidToStringSid(
           IntPtr pSid, 
           ref string strSid);

       [DllImport("advapi32.dll", SetLastError=true)]
       public static extern bool ImpersonateLoggedOnUser(
           IntPtr hToken);

       [DllImport("kernel32.dll", SetLastError=true)]
       public static extern bool CloseHandle(
           IntPtr hHandle);

       [DllImport("kernel32.dll", SetLastError = true)]
       public static extern IntPtr OpenThread(
           ThreadAccess dwDesiredAccess, 
           bool bInheritHandle,
           uint dwThreadId);


       [DllImport("advapi32.dll", SetLastError=true)]
       public static extern bool OpenThreadToken(
           IntPtr ThreadHandle,
           uint DesiredAccess,
           bool OpenAsSelf,
           ref IntPtr TokenHandle);

       [DllImport("advapi32.dll")]
       public extern static bool DuplicateToken(
           IntPtr ExistingTokenHandle, 
           int SECURITY_IMPERSONATION_LEVEL, 
           ref IntPtr DuplicateTokenHandle
           );

       [DllImport("advapi32.dll", SetLastError = true)]
       public static extern bool RevertToSelf();
   }
}
'@
Add-Type -TypeDefinition $TypeDef
}
function Get-LogonSessionProcesses

  <#
  .SYNOPSIS

  Gets information about processes tied to a specific LogonId.

  .DESCRIPTION

  Get-LogonSessionProcesses will obtain information regarding processes tied to a given LogonID and with it any network connections that process may have.

  .PARAMETER Id
  
  Integer value of the LogonId analyst wants to find processes for. 

  .PARAMETER IncludeLinked
  
  Switch to also show processes of a logon session's linked token.

  .PARAMETER IncludeOnlyNetwork
  
  Switch to only return processes with network events.

  .EXAMPLE
  
  Get-LogonSessionProcesses -Id <LogonId> 

  .EXAMPLE
  
  Get-LogonSessionProcesses -Id <LogonId> -IncludeLinked

   .EXAMPLE
  
  Get-LogonSessionProcesses -Id <LogonId> -IncludeLinked -IncludeOnlyNetwork

  .NOTES
  Author: Jonathan Johnson (@jsecurity101)
  Dependencies: None
  References: This is updated code from  Lee Christensen (@tifkin_) https://github.com/leechristensen/Random/blob/master/PowerShellScripts/Get-LogonSessionProcesses.ps1
  #>
{
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
      [int[]]
      $Id,

      [switch]
      $IncludeLinked,

      [switch]
      $IncludeOnlyNetwork
  )

  $capture =  logman create trace -n NetworkCapture -p Microsoft-Windows-Kernel-Network 0xFFFFFFFFFFFFFFFF 0xFF -o Network.etl -ets
  sleep 60
  $endcapture = logman stop NetworkCapture -ets

  foreach($LogonId in $Id)
  {
      $WQL = Get-WmiObject -Query ("ASSOCIATORS OF {Win32_LogonSession.LogonId=$LogonId} WHERE ResultClass = Win32_Process")
      foreach ($Result in $WQL){
          $ProcessId = $Result.ProcessId
          $pHandle = [TokenInformation.ProcessNativeMethods]::OpenProcess(
               [TokenInformation.ProcessAccess]::QueryLimitedInformation, #dwDesiredAccess
               $False, #bInheritHandle
               $ProcessId  #dwProcessId
           );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

           if ($pHandle -eq [IntPtr]::Zero) {
               $ErrorString = "OpenProcess failed for $($Result.ProcessId)"
               Write-Warning $ErrorString
               return
           }
           $TokenHandle = [IntPtr]::Zero
           $TokenResult = [TokenInformation.ProcessNativeMethods]::OpenProcessToken(
               $pHandle,
               [TokenInformation.TokenAccess] 'TOKEN_QUERY, TOKEN_QUERY_SOURCE',
               [Ref] $TokenHandle
           );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

           if (!$TokenResult) {
               throw $LastError
           }
           $ProcessInformation = "Displaying Process/Primary Information"
           $ProcessTokenUser = Get-TokenInformation -TokenInformation TokenUser -TokenHandle $TokenHandle
           $ProcessTokenOwner = Get-TokenInformation -TokenInformation TokenOwner -TokenHandle $TokenHandle
           $ProcessTokenType = Get-TokenInformation -TokenInformation TokenType -TokenHandle $TokenHandle
           $ProcessTokenStatistic = Get-TokenInformation -TokenInformation TokenStatistics -TokenHandle $TokenHandle
           $ProcessTokenIntegrityLevel = Get-TokenInformation -TokenInformation TokenIntegrityLevel -TokenHandle $TokenHandle 
           $ProcessTokenLinkedToken = Get-TokenInformation -TokenInformation TokenLinkedToken -TokenHandle $TokenHandle 
           $BuddyLogonId = $ProcessTokenLinkedToken.BuddyLogonId
           $NetworkResult = @{}
           $EventResult = $null 
           $EventResult = Get-WinEvent -Path .\Network.etl -Oldest  -FilterXPath "*[System[(EventID = 12)] and EventData[Data[@Name='PID'] = $ProcessId]]" -ErrorAction Ignore
           if ($EventResult -ne $null){
               $EventResult | % {$Daddr = [System.Net.IPAddress]::Parse($_.Properties[2].Value); $DaddrFinal=[System.Net.IPAddress]::Parse($Daddr.Address).IPAddressToString}
               $EventResult | % {$Saddr = [System.Net.IPAddress]::Parse($_.Properties[3].Value); $SaddrFinal=[System.Net.IPAddress]::Parse($Saddr.Address).IPAddressToString}
               $EventResult | % {$Message = $_.Message}

               $NetworkResult = [PSCustomObject] @{
               SourceAddress = $SaddrFinal
               DestinationAddress = $DaddrFinal
               PID = $ProcessId
               Message = $Message

               }
           }
          
          if($IncludeOnlyNetwork){
              if($NetworkResult[0] -ne $null){
                  [PSCustomObject] @{
                       Title = $ProcessInformation
                       ProcessName = $Result.ProcessName 
                       SessionId = $Result.SessionId
                       ProcessId = $Result.ProcessId 
                       ProcessTokenUserName = $ProcessTokenUser.Username
                       ProcessTokenSid = $ProcessTokenUser.Sid 
                       ProcessLogonSid = '{0:x}' -f $ProcessTokenStatistic.LogonId
                       ProcessBuddyLogonSid = '{0:x}' -f $ProcessTokenLinkedToken.BuddyLogonId
                       ProcessTokenType = $ProcessTokenType.TokenType
                       ProcessTokenId = $ProcessTokenStatistic.TokenId
                       TokenIntegrityLevel = $ProcessTokenIntegrityLevel
                       NetworkEvents = $NetworkResult
                   }
              }
          }
          else{
           [PSCustomObject] @{
               Title = $ProcessInformation
               ProcessName = $Result.ProcessName 
               SessionId = $Result.SessionId
               ProcessId = $Result.ProcessId 
               ProcessTokenUserName = $ProcessTokenUser.Username
               ProcessTokenSid = $ProcessTokenUser.Sid 
               ProcessLogonSid = '{0:x}' -f $ProcessTokenStatistic.LogonId
               ProcessBuddyLogonSid = '{0:x}' -f $ProcessTokenLinkedToken.BuddyLogonId
               ProcessTokenType = $ProcessTokenType.TokenType
               ProcessTokenId = $ProcessTokenStatistic.TokenId
               TokenIntegrityLevel = $ProcessTokenIntegrityLevel
               NetworkEvents = $NetworkResult
              }
          }
          $Close = [TokenInformation.ProcessNativeMethods]::CloseHandle($TokenHandle)
          $Close = [TokenInformation.ProcessNativeMethods]::CloseHandle($pHandle)
      }
      if($IncludeLinked){
          $WQL = Get-WmiObject -Query ("ASSOCIATORS OF {Win32_LogonSession.LogonId=$BuddyLogonId} WHERE ResultClass = Win32_Process")
          foreach ($Result in $WQL){
              $ProcessId = $Result.ProcessId
              $pHandle = [TokenInformation.ProcessNativeMethods]::OpenProcess(
                   [TokenInformation.ProcessAccess]::QueryLimitedInformation, #dwDesiredAccess
                   $False, #bInheritHandle
                   $Result.ProcessId  #dwProcessId
               );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

               if ($pHandle -eq [IntPtr]::Zero) {
                   $ErrorString = "OpenProcess failed for $($Result.ProcessId)"
                   Write-Warning $ErrorString
                   return
               }
               $TokenHandle = [IntPtr]::Zero
               $TokenResult = [TokenInformation.ProcessNativeMethods]::OpenProcessToken(
                   $pHandle,
                   [TokenInformation.TokenAccess] 'TOKEN_QUERY, TOKEN_QUERY_SOURCE',
                   [Ref] $TokenHandle
               );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

               if (!$TokenResult) {
                   throw $LastError
               }
               $ProcessInformation = "Displaying Process/Primary Information"
               $ProcessTokenUser = Get-TokenInformation -TokenInformation TokenUser -TokenHandle $TokenHandle
               $ProcessTokenOwner = Get-TokenInformation -TokenInformation TokenOwner -TokenHandle $TokenHandle
               $ProcessTokenType = Get-TokenInformation -TokenInformation TokenType -TokenHandle $TokenHandle
               $ProcessTokenStatistic = Get-TokenInformation -TokenInformation TokenStatistics -TokenHandle $TokenHandle
               $ProcessTokenIntegrityLevel = Get-TokenInformation -TokenInformation TokenIntegrityLevel -TokenHandle $TokenHandle 
               $ProcessTokenLinkedToken = Get-TokenInformation -TokenInformation TokenLinkedToken -TokenHandle $TokenHandle 
               $NetworkResult = $null #clearing out events
               $NetworkResult = @{}
               $EventResult = $null 
               $EventResult = Get-WinEvent -Path .\Network.etl -Oldest  -FilterXPath "*[System[(EventID = 12)] and EventData[Data[@Name='PID'] = $ProcessId]]" -ErrorAction Ignore
               if ($EventResult -ne $null){
                   $EventResult | % {$Daddr = [System.Net.IPAddress]::Parse($_.Properties[2].Value); $DaddrFinal=[System.Net.IPAddress]::Parse($Daddr.Address).IPAddressToString}
                   $EventResult | % {$Saddr = [System.Net.IPAddress]::Parse($_.Properties[3].Value); $SaddrFinal=[System.Net.IPAddress]::Parse($Saddr.Address).IPAddressToString}
                   $EventResult | % {$Message = $_.Message}

                   $NetworkResult = [PSCustomObject] @{
                   SourceAddress = $SaddrFinal
                   DestinationAddress = $DaddrFinal
                   PID = $ProcessId
                   Message = $Message

                   }
               }
          
               if($IncludeOnlyNetwork){
                  if($NetworkResult[0] -ne $null){
                      [PSCustomObject] @{
                           Title = $ProcessInformation
                           ProcessName = $Result.ProcessName 
                           SessionId = $Result.SessionId
                           ProcessId = $Result.ProcessId 
                           ProcessTokenUserName = $ProcessTokenUser.Username
                           ProcessTokenSid = $ProcessTokenUser.Sid 
                           ProcessLogonSid = '{0:x}' -f $ProcessTokenStatistic.LogonId
                           ProcessBuddyLogonSid = '{0:x}' -f $ProcessTokenLinkedToken.BuddyLogonId
                           ProcessTokenType = $ProcessTokenType.TokenType
                           ProcessTokenId = $ProcessTokenStatistic.TokenId
                           TokenIntegrityLevel = $ProcessTokenIntegrityLevel
                           NetworkEvents = $NetworkResult
                       }
                  }
              }
              else{
               [PSCustomObject] @{
                   Title = $ProcessInformation
                   ProcessName = $Result.ProcessName 
                   SessionId = $Result.SessionId
                   ProcessId = $Result.ProcessId 
                   ProcessTokenUserName = $ProcessTokenUser.Username
                   ProcessTokenSid = $ProcessTokenUser.Sid 
                   ProcessLogonSid = '{0:x}' -f $ProcessTokenStatistic.LogonId
                   ProcessBuddyLogonSid = '{0:x}' -f $ProcessTokenLinkedToken.BuddyLogonId
                   ProcessTokenType = $ProcessTokenType.TokenType
                   ProcessTokenId = $ProcessTokenStatistic.TokenId
                   TokenIntegrityLevel = $ProcessTokenIntegrityLevel
                   NetworkEvents = $NetworkResult
                  }
              }
              $Close = [TokenInformation.ProcessNativeMethods]::CloseHandle($TokenHandle)
              $Close = [TokenInformation.ProcessNativeMethods]::CloseHandle($pHandle)
          }
      }
  }
  $null = Remove-Item Network.etl
}
function Get-TokenInformation {
   <#
   .SYNOPSIS

   Gets token information given a specific process.

   .DESCRIPTION

   Get-TokenInformation will obtain information about a token's user.

   .NOTES

   Author: Jonathan Johnson (@jsecurity101)
   Dependencies: None
   References: PInvoke / https://gist.github.com/jaredcatkinson/17698b39efd72f976a6a846ec3a8eacd
   #>

   param (
       [Parameter(Mandatory=$true)]
       [IntPtr]
       $TokenHandle,

       [Parameter(Mandatory= $true)]
       [string]
       $TokenInformation
   )

   $TokenLength = 0
   $TokenPtr = [IntPtr]::Zero

   $Result = [TokenInformation.ProcessNativeMethods]::GetTokenInformation(
       $TokenHandle,
       [TokenInformation.TOKEN_INFORMATION_CLASS]::$TokenInformation,
       [IntPtr]::Zero,
       $TokenLength,
       [Ref] $TokenLength
   );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

  [IntPtr]$TokenPtr = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($TokenLength)
  
   $Result = [TokenInformation.ProcessNativeMethods]::GetTokenInformation(
       $TokenHandle,
       [TokenInformation.TOKEN_INFORMATION_CLASS]::$TokenInformation,
       $TokenPtr,
       $TokenLength,
       [Ref] $TokenLength
   );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()


   if($Result) {
       switch ($TokenInformation)
       {
           TokenUser
               {
                   $TokenUser = [System.Runtime.InteropServices.Marshal]::PtrToStructure($TokenPtr, [System.Type][TokenInformation.TOKEN_USER])
                   $StringPtr = [IntPtr]::Zero
               
                   $UserSid = [TokenInformation.ProcessNativeMethods]::ConvertSidToStringSid(
                       $TokenUser.User.Sid,
                       [ref]$StringPtr
                   );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

                   if(!$UserSid) {
                       throw $LastError
                   }

                   $Sid = New-Object System.Security.Principal.SecurityIdentifier($StringPtr)
                   $UserName = $Sid.Translate([System.Security.Principal.NTAccount])

                   $obj = New-Object -TypeName psobject -Property $props
                   $obj | Add-Member -MemberType NoteProperty -Name ProcessName -Value $p.Name 
                   $obj | Add-Member -MemberType NoteProperty -Name SID -Value $Sid
                   $obj | Add-Member -MemberType NoteProperty -Name Username -Value $UserName

                   Write-Output $obj
               }
     
           TokenType
           {
               if($TokenPtr -ne $null){
                   $TokenType = [System.Runtime.InteropServices.Marshal]::ReadInt32($TokenPtr) -as [System.Type][TokenInformation.TOKEN_TYPE]
                   $obj = New-Object -TypeName psobject -Property $props
                   $obj | Add-Member -MemberType NoteProperty -Name TokenType -Value $TokenType
                   Write-Output $obj
               }

           }

           TokenImpersonationLevel
           {
               Write-Output ([System.Runtime.InteropServices.Marshal]::ReadInt32($TokenPtr) -as [System.Type][TokenInformation.SECURITY_IMPERSONATION_LEVEL])
           }

           TokenStatistics 
           {
               $TokenStatistics = [System.Runtime.InteropServices.Marshal]::PtrToStructure($TokenPtr, [System.Type][TokenInformation.TOKEN_STATISTICS])


               [PSCustomObject] @{
                   TokenId = $TokenStatistics.TokenId.LowPart
                   LogonId = $TokenStatistics.AuthenticationId.LowPart
                   # Recovered portion follows
                   TokenType = $TokenStatistics.TokenType
                   TokenImpersonationLevel = $TokenStatistics.TokenImpersonationLevel
               }
           }

           TokenIntegrityLevel
           {
               $TokenIntegrityLevel = [System.Runtime.InteropServices.Marshal]::PtrToStructure($TokenPtr, [System.Type][TokenInformation.TOKEN_MANDATORY_LABEL])

                $StringPtr = [IntPtr]::Zero
               
               $TokenSID = [TokenInformation.ProcessNativeMethods]::ConvertSidToStringSid(
                   $TokenIntegrityLevel.Label.Sid,
                   [ref]$StringPtr
               );$LastError = [ComponentModel.Win32Exception][Runtime.InteropServices.Marshal]::GetLastWin32Error()

               if(!$TokenSID) {
                   throw $LastError
               }

               $TokenIntegritySID = New-Object System.Security.Principal.SecurityIdentifier($StringPtr)

              #Reference: https://docs.microsoft.com/en-US/windows/security/identity-protection/access-control/security-identifiers
               if ($TokenIntegritySID -eq 'S-1-16-0')
               {
                   Write-Output "UNTRUSTED_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-4096')
               {
                   Write-Output "LOW_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-8192')
               {
                   Write-Output "MEDIUM_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-8448')
               {
                   Write-Output "MEDIUM_PLUS_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-12288')
               {
                   Write-Output "HIGH_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-16384')
               {
                   Write-Output "SYSTEM_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-20480')
               {
                   Write-Output "PROTECTED_PROCESS_MANDATORY_LEVEL"
               }
               if ($TokenIntegritySID -eq 'S-1-16-28672')
               {
                   Write-Output "SECURE_PROCESS_MANDATORY_LEVEL"
               }

           }
           TokenLinkedToken {
              $LinkedLToken = [System.Runtime.InteropServices.Marshal]::PtrToStructure($TokenPtr, [System.Type][TokenInformation.TOKEN_LINKED_TOKEN])
              $LinkedHandle = $LinkedLToken.LinkedToken
              $LinkedLTokenResult = Get-TokenInformation -TokenInformation TokenStatistics -TokenHandle $LinkedHandle
              [PSCustomObject] @{
                   BuddyLogonId = $LinkedLTokenResult.LogonId
               }
              $null  = [TokenInformation.ProcessNativeMethods]::CloseHandle($LinkedHandle)
           
           }

          }  
   }

}


Get-LogonSessionProcesses