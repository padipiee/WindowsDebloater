
echo Deleting spyware tasks FULL ...
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