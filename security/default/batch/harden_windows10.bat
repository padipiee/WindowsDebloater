REM based on , v. 2.2.4. Credit  https://gist.github.com/IntergalacticApps/675339c2b805b4c9c6e9a442e0121b1d
REM IntergalacticApps/make_windows10_great_again.bat
REM


@echo off
setlocal EnableDelayedExpansion

ver | find "10." > nul
if errorlevel 1 (
	echo Your Windows version is not Windows 10...exiting...
	pause
	exit
) else (
	echo Your Windows version is   Windows 10! Lets proceed.
)

echo This is a batch spyware remover, trash remover and security hardenning script
pause

echo.
echo | set /p=Checking permissions... 
net session >nul 2>&1
if errorlevel 1 (
	echo Permission denied. Run this script as administrator.
	pause
	exit
) else (
	echo The permissions as administrator are OK to continue further!
	timeout /t 1 > nul
)

reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "ProductName" | find "LTSB" > nul
if not errorlevel 1 (
	set LTSB=1
)

if not defined LTSB (
	cls
	echo 0001 - Deleting trash apps...
	powershell -Command "& {Get-AppxPackage -AllUsers | Remove-AppxPackage; Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online;}"
	takeown /f "%ProgramFiles%\WindowsApps" /r
	icacls "%ProgramFiles%\WindowsApps" /inheritance:e /grant "%UserName%:(OI)(CI)F" /T /C
	for /d %%i in ("%ProgramFiles%\WindowsApps\*") do (
		rd /s /q "%%i"
	)
	icacls "%ProgramFiles%\WindowsApps" /setowner "NT Service\TrustedInstaller"
	icacls "%ProgramFiles%\WindowsApps" /inheritance:r /remove "%UserName%"
)




if not defined LTSB (
	echo | set /p=0015 - Disable device access for Universal Apps LTSB
set edge_path=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-3624051433-2125758914-1423191267-1740899205-1073925389-3782572162-737981194
reg add !edge_path!\{2EEF81BE-33FA-4800-9670-1CD474972C3F} /v "Value" /t REG_SZ /d "Deny" /f 
reg add !edge_path!\{E5323777-F976-4f5b-9B55-B94699C46E44} /v "Value" /t REG_SZ /d "Deny" /f 
)


echo [OK]


if not defined LTSB (
	echo | set /p=0017 - Disable background access for Universal Apps 
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.PPIProjection_cw5n1h2txyewy" /v "Disabled" /t REG_DWORD /d 1 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.PPIProjection_cw5n1h2txyewy" /v "DisabledByUser" /t REG_DWORD /d 1 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Windows.ContactSupport_cw5n1h2txyewy" /v "Disabled" /t REG_DWORD /d 1 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Windows.ContactSupport_cw5n1h2txyewy" /v "DisabledByUser" /t REG_DWORD /d 1 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /v "Disabled" /t REG_DWORD /d 1 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /v "DisabledByUser" /t REG_DWORD /d 1 /f > nul
	echo [OK]
)



echo | set /p=Disable Windows Defender 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d 4 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d 4 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdBoot" /v "Start" /t REG_DWORD /d 4 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d 4 /f > nul 2>&1
regsvr32 /s /u "%ProgramFiles%\Windows Defender\shellext.dll"
taskkill /f /im MSASCuiL.exe > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f > nul 2>&1
echo [OK]

if not defined LTSB (
	echo | set /p=Disable Windows Store 
	reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f > nul
	reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 1 /f > nul
	reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f > nul
	echo [OK]
)

echo | set /p=Disable Delivery Optimization 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable Program Compatibility Assistant 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable Windows Error Reporting 
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f > nul
echo [OK]




if not defined LTSB (
	echo | set /p=Disable ads on lock screen 
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "LockImageFlags" /t REG_DWORD /d 0 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "CreativeId" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "PortraitAssetPath" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "LandscapeAssetPath" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "DescriptionText" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ActionText" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ActionUri" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "PlacementId" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ClickthroughToken" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ImpressionToken" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "HotspotImageFolderPath" /t REG_SZ /d "" /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "CreativeJson" /t REG_SZ /d "" /f > nul
	echo [OK]
)

echo | set /p=Disable File History 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Active Help 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d 1 /f > nul
echo [OK]



echo | set /p=Disable Windows Feedback 
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f > nul


echo | set /p=Disable Microsoft Help feedback 
reg add "HKCU\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable feedback on write 
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable lock screen camera 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable password reveal button 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Windows Insider Program 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable DRM features 
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Office 2016 telemetry 
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "Enablelogging" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "EnableUpload" /t REG_DWORD /d 0 /f > nul
echo [OK]

if not defined LTSB (
	echo | set /p=Disable Adobe Flash Player in Microsoft Edge 
	reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d 0 /f > nul
	echo [OK]
)



echo | set /p=Disable Live Tiles 
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoTileApplicationNotification" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable AutoPlay and AutoRun 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Remote Assistance 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable administrative shares 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Do not send Windows Media Player statistics 
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Remove 3D Builder from context menu 
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\T3D Print" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\T3D Print" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\T3D Print" /f > nul 2>&1
echo [OK]

echo | set /p=Set default PhotoViewer 
reg add "HKCU\SOFTWARE\Classes\.ico" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.bmp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.png" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.gif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.jpg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
echo [OK]

echo | set /p=Turn off "You have new apps that can open this type of file" alert 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d 1 /f > nul
echo [OK]

if not defined LTSB (
	echo | set /p=Turn off "Look For An App In The Store" option 
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f > nul
	echo [OK]
)

echo | set /p=Open File Explorer to This PC instead of Quick Access 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Do not show recently used files in Quick Access 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Do not show frequently used folders in Quick Access 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Show hidden files, folders and drives in File Explorer 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Show file extensions in File Explorer 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Launch folder windows in a separate process 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Auto-end non responsive tasks 
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f > nul
echo [OK]

echo | set /p=Maximize wallpaper quality 
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 100 /f > nul
echo [OK]

echo | set /p=Set icon cache size to 4096 KB 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "Max Cached Icons" /t REG_SZ /d "4096" /f > nul
echo [OK]

echo | set /p=Add Recycle Bin to Navigation Pane 
reg add "HKCU\SOFTWARE\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Restore Classic Context Menu in Explorer 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Set "Do this for all current items" checkbox by default in the file operation conflict dialog 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "ConfirmationCheckBoxDoForAll" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Enable NTFS long paths 
reg add "HKLM\SYSTEM\CurrentControlSet\Policies" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f > nul
echo [OK]

REM https://www.bleepingcomputer.com/startups/adminservice.exe-26606.html

reg query "HKLM\SYSTEM\CurrentControlSet\Services\AtherosSvc\Start" > nul
if not errorlevel 1 (
	echo | set /p=Disable AtherosSvc Bluetooth service - adminservice.exe - driver development kit (DDK)
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\AtherosSvc" /v "Start" /t REG_DWORD /d 4 /f > nul 2>&1
)


echo.
echo | set /p=Restarting Explorer... 
taskkill /f /im explorer.exe >nul & explorer.exe
schtasks /delete /tn "CreateExplorerShellUnelevatedTask" /f > nul
echo OK.

echo.
echo Deleting spyware tasks...
set spy_tasks=^
	"Microsoft\Office\Office 15 Subscription Heartbeat"^
	"Microsoft\Office\OfficeTelemetryAgentFallBack2016"^
	"Microsoft\Office\OfficeTelemetryAgentLogOn2016"^
	"Microsoft\Windows\AppID\SmartScreenSpecific"^
	"Microsoft\Windows\Application Experience\AitAgent"^
	"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"^
	"Microsoft\Windows\Application Experience\ProgramDataUpdater"^
	"Microsoft\Windows\Application Experience\StartupAppTask"^
	"Microsoft\Windows\Autochk\Proxy"^
	"Microsoft\Windows\Clip\License Validation"^
	"Microsoft\Windows\CloudExperienceHost\CreateObjectTask"^
	"Microsoft\Windows\Customer Experience Improvement Program\BthSQM"^
	"Microsoft\Windows\Customer Experience Improvement Program\Consolidator"^
	"Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"^
	"Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"^
	"Microsoft\Windows\Device Information\Device"^
	"Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"^
	"Microsoft\Windows\Feedback\Siuf\DmClient"^
	"Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"^
	"Microsoft\Windows\License Manager\TempSignedLicenseExchange"^
	"Microsoft\Windows\Location\Notifications"^
	"Microsoft\Windows\Location\WindowsActionDialog"^
	"Microsoft\Windows\Maps\MapsToastTask"^
	"Microsoft\Windows\Maps\MapsUpdateTask"^
	"Microsoft\Windows\Media Center\ActivateWindowsSearch"^
	"Microsoft\Windows\Media Center\ConfigureInternetTimeService"^
	"Microsoft\Windows\Media Center\DispatchRecoveryTasks"^
	"Microsoft\Windows\Media Center\ehDRMInit"^
	"Microsoft\Windows\Media Center\InstallPlayReady"^
	"Microsoft\Windows\Media Center\mcupdate"^
	"Microsoft\Windows\Media Center\MediaCenterRecoveryTask"^
	"Microsoft\Windows\Media Center\ObjectStoreRecoveryTask"^
	"Microsoft\Windows\Media Center\OCURActivate"^
	"Microsoft\Windows\Media Center\OCURDiscovery"^
	"Microsoft\Windows\Media Center\PBDADiscovery"^
	"Microsoft\Windows\Media Center\PBDADiscoveryW1"^
	"Microsoft\Windows\Media Center\PBDADiscoveryW2"^
	"Microsoft\Windows\Media Center\PvrRecoveryTask"^
	"Microsoft\Windows\Media Center\PvrScheduleTask"^
	"Microsoft\Windows\Media Center\RegisterSearch"^
	"Microsoft\Windows\Media Center\ReindexSearchRoot"^
	"Microsoft\Windows\Media Center\SqlLiteRecoveryTask"^
	"Microsoft\Windows\Media Center\UpdateRecordPath"^
	"Microsoft\Windows\Maintenance\WinSAT"^
	"Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"^
	"Microsoft\Windows\RetailDemo\CleanupOfflineContent"^
	"Microsoft\Windows\SettingSync\BackgroundUploadTask"^
	"Microsoft\Windows\SettingSync\BackupTask"^
	"Microsoft\Windows\SettingSync\NetworkStateChangeTask"^
	"Microsoft\Windows\Shell\FamilySafetyMonitor"^
	"Microsoft\Windows\Shell\FamilySafetyMonitorToastTask"^
	"Microsoft\Windows\Shell\FamilySafetyRefresh"^
	"Microsoft\Windows\Shell\FamilySafetyRefreshTask"^
	"Microsoft\Windows\Speech\SpeechModelDownloadTask"^
	"Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"^
	"Microsoft\Windows\Windows Defender\Windows Defender Cleanup"^
	"Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"^
	"Microsoft\Windows\Windows Defender\Windows Defender Verification"^
	"Microsoft\Windows\Windows Error Reporting\QueueReporting"^
	"Microsoft\Windows\WindowsUpdate\Automatic App Update"^
	"Microsoft\Windows\WindowsUpdate\sih"^
	"Microsoft\Windows\WindowsUpdate\sihboot"^
	"Microsoft\Windows\WS\License Validation"^
	"Microsoft\Windows\WS\WSTask"^
	"Microsoft\XblGameSave\XblGameSaveTask"^
	"Microsoft\XblGameSave\XblGameSaveTaskLogon"
set tasks_dir=%SystemRoot%\System32\Tasks
for %%i in (%spy_tasks%) do (
	schtasks /query /tn %%i > nul 2>&1
	if not errorlevel 1 (
		echo | set /p=%%i
		schtasks /delete /tn %%i /f > nul
		set item=%%i
		set dir_path="%tasks_dir%\!item:~1!
		mkdir !dir_path!
		icacls !dir_path! /deny "Everyone:(OI)(CI)W" > nul
		set spy_task_deleted=1
		echo  [OK]
	)
)
if not defined spy_task_deleted (
	echo Spyware tasks already deleted.
)

set update_orchestrator_dir=%tasks_dir%\Microsoft\Windows\UpdateOrchestrator
if not exist %update_orchestrator_dir%\Reboot\ (
	echo.
	echo | set /p=Prevent Windows 10 reboots after installing updates... 
	schtasks /delete /tn "Microsoft\Windows\UpdateOrchestrator\Reboot" /f > nul 2>&1
	mkdir %update_orchestrator_dir%\Reboot
	icacls %update_orchestrator_dir%\Reboot /deny "Everyone:(OI)(CI)W" > nul
	echo OK.
)

echo.
echo Finished.
pause