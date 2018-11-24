
# Purpose
Remove unecessary Windows 10 apps, disable Telemetry and plenty of bloatware and spying default features and disable them when possible.
Attempts to improve security and privacy posture of default configurations.

# Sources / Credits
Use various ideas originally from various sources and then add variants, modifications and optimizations
- Sycnex/Windows10Debloater
- IntergalacticApps/make_windows10_great_again.bat
- 10se1ucgo/DisableWinTracking


# Windows10Debloater
Download the Windows10Debloater.ps1 file. Next, open PowerShell ISE/VSCode as an Administrator, copy the source code from Windows10Debloater.ps1 and throw it into PowerShell ISE/VSCode/etc and run it.

Alternatively, download the Windows10SysPrepDebloater.ps1 file, place it in any directory of your choice, load PowerShell ISE or PowerShell (64-Bit)/VSCode as an administrator, change to the directory where you placed the Windows10SysPrepDebloater.ps1 file, and run one (or all) of the 3 switch parameters: -SysPrep, -Debloat, and -StopEdgePDF. E.g., C:\Windows10SysPrepDebloater.ps1 -SysPrep -Debloat -StopEdgePDF.

This script will remove the bloatware from Windows 10 when using Remove-AppXPackage/Remove-AppXProvisionedPackage, and then delete specific registry keys that are were not removed beforehand. For best results, this script should be ran before a user profile is configured, otherwise you will likely see that apps that should have been removed will remain, and if they are removed you will find broken tiles on the start menu.


# Batch script make_windows10_great_again
Batch script that combine plenty of features (uninstall apps, add hardenning features, disable apps)

# DisableWinTracking
Various python scripts for the same purpose.
Describe ways for a  Clean removal of system apps (bypass error 0x80073CFA)
