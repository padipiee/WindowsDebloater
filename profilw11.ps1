# Set-ExecutionPolicy Unrestricted
# 0002_git_config_global.ps1

############################################################
#
############################################################
./security/default/0004_Delete_OneDrive_64bits.ps1
./security/default/0008_Disable_OneDrive_file_sync.ps1
./security/default/0009_Delete_services.ps1
./security/default/0010_Disable_unsafe_services.ps1
./security/default/0011_Disable_Collect_Activity_History_PublishUserActivities.ps1
./security/default/0016_Disable_global_Telemetry_AllowTelemetry.ps1
./security/default/0017_Disable_Application_Telemetry.ps1
./security/default/0018_Disable_Inventory_Collector.ps1
./security/default/0019_Disable_Steps_Recorder.ps1
./security/default/0020_Disable_Advertising_ID.ps1
./security/default/0021_Disable_keylogger_InputPersonalization.ps1
./security/default/0023_Disable_browser_access_to_local_language.ps1
./security/default/0024_Disable_SmartScreen.ps1
./security/default/0025_Disable_Advertising_ID_for_Relevant_Ads.ps1
./security/default/0026-001_Deleting_microsoft_task_Microsoft_Compatibility_Appraiser_only.ps1
./security/default/0030_Disable_biometrics.ps1
./security/default/0031_Disable_Program_Compatibility_Assistant.ps1
./security/default/0035_Disable_cortana.ps1
./security/default/0037_Disable_Windows_Consumer_Features.ps1
#./security/default/0038_Disable_Bluetooth.ps1  ##? HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions\All\SystemSettings_Device_BluetoothQuickAction"
./security/default/0040_Disable_anonymous_enumeration.ps1
./security/default/0042_Disable_SSDP_Discovery_Service.ps1
#./security/default/0043_Disable_DiagTrack.ps1  #not found Windows 11
./security/default/0044_Disable_NVIDIA_Container_Telemetry.ps1 
./security/default/0046_Disable_App_Access_To_Voice_Activation_When_Device_Is_Locked.ps1
./security/default/0047_Disable_App_Access_To_Voice_Activation.ps1
./security/default/0048_Disable_Use_of_Windows_Hello_Biometrics.ps1
./security/default/0049_Disable_Netbios.ps1

./security/default/0056_Disable_with_policy_apprivacy.ps1
./security/default/0057_Disable_via_DoNotShowFeedbackNotifications.ps1
./security/default/0058_Disable_game_DVR.ps1


#
./security/default/0364_get_chocolatey_iex.ps1
./security/default/0365_choco_upgrade_nmap.ps1
./security/default/0366_install_powershell7.ps1
./security/default/0368_block_msedge_telemetry.ps1


############################################
# On demand . Enable if needed
############################################
#./security/default/0029_List_all_scheduled_tasks.ps1
#./security/default/0367_monitor_ip_trafic.ps1

