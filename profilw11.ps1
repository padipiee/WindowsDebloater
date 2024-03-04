Set-ExecutionPolicy Unrestricted
# 0002_git_config_global.ps1

############################################################
#
############################################################
./security/default/0004_Disable_OneDrive_Policies_DisableFileSyncNGSC.ps1
#./security/default/0005_Remove_OneDrive_32bits_folder_From_File_Explorer
./security/default/0008_Disable_OneDrive_file_sync.ps1
#./security/default/0009_Delete_services.ps1
#./security/default/0009.01_Delete_services_diagtrack.ps1
#./security/default/0009.02_Delete_services_dmwappushservice.ps1
./security/default/0010_Disable_unsafe_services.ps1
./security/default/0010.01_Disable_unsafe_services_remoteregistry.ps1
./security/default/0010.02_Disable_unsafe_services_TermService.ps1
./security/default/0011_Disable_Collect_Activity_History_PublishUserActivities.ps1
./security/default/0016_Disable_global_Telemetry_AllowTelemetry.ps1
./security/default/0017_Disable_Application_Telemetry.ps1
./security/default/0018_Disable_Inventory_Collector.ps1
./security/default/0019_Disable_Steps_Recorder.ps1
./security/default/0020_Disable_Advertising_ID_DisabledByGroupPolicy.ps1
./security/default/0021_Disable_keylogger_InputPersonalization.ps1
./security/default/0023_Disable_browser_access_to_local_language.ps1
#./security/default/0024_Disable_SmartScreen.ps1
./security/default/0025_Disable_Advertising_ID_for_Relevant_Ads_Enabled.ps1
./security/default/0026.01_Deleting_microsoft_task_Microsoft_Compatibility_Appraiser_only.ps1
./security/default/0030_Disable_biometrics.ps1
./security/default/0030.01_Disable_biometrics_WbioSrvc.ps1
./security/default/0031_Disable_Program_Compatibility_Assistant.ps1
./security/default/0036_Disable_cortana-registry.ps1
./security/default/0036.01_Disable_cortana-registry_AllowCortana.ps1
./security/default/0036.02_Disable_cortana-registry_DisableWebSearch.ps1
./security/default/0036.03_Disable_cortana-registry_AllowSearchToUseLocation.ps1
./security/default/0037_Disable_Windows_Consumer_Features_SystemPaneSuggestionsEnabled.ps1
./security/default/0040_Disable_anonymous_enumeration_restrictanonymous.ps1
./security/default/0042_Disable_SSDP_Discovery_Service.ps1
./security/default/0043_Disable_DiagTrack.ps1
./security/default/0044_Disable_NVIDIA_Container_Telemetry.ps1 
./security/default/0046_Disable_App_Access_To_Voice_Activation_When_Device_Is_Locked.ps1
./security/default/0047_Disable_App_Access_To_Voice_Activation.ps1
./security/default/0048_Disable_Use_of_Windows_Hello_Biometrics.ps1
./security/default/0049_Disable_Netbios.ps1
./security/default/0050.01_Disable_OneSync_service_OneSyncSvc.ps1
./security/default/0050.02_Disable_OneSync_service_OneSyncSvc_8b42a.ps1
#./security/default/0053_Chrome_disable_elevation_service.bat
./security/default/0055_Disable_windows_customer_experience_improvement_program_CorporateSQMURL.ps1
./security/default/0056_Disable_with_policy_apprivacy.ps1
./security/default/0057_Disable_via_DoNotShowFeedbackNotifications.ps1
./security/default/0058.01_Disable_game_DVR_GameDVR_Enabled.ps1
./security/default/0058.02_Disable_game_DVR_AllowGameDVR.ps1
#./security/default/0059_Block_telemetry_microsoft_firewall.ps1
./security/default/0059.001_Block_telemetry_microsoft_firewall_vortex-data-microsoft_191-232-139-254.ps1
./security/default/0072.01_Disable_loggers_ControlSet001_AutoLogger-Diagtrack-Listener.ps1
./security/default/0072.02_Disable_loggers_CurrentControlSet_AutoLogger-Diagtrack-Listener.ps1
./security/default/0072.03_Disable_loggers_SQMLogger.ps1
./security/default/0073_Disable_WMI_Autologger_CloudExperienceHostOobe.ps1
./security/default/0077_Disable_Microsoft_Windows_Maps_sched_task.ps1
./security/default/0079_Disable_Windows_tips_DisableSoftLanding.ps1
./security/default/0080_List_BITS.ps1
./security/default/0085_Disable_Wi-Fi.ps1
./security/default/0086_Disable_location_access_and_sensors.ps1
./security/default/0091_Query_shell_extensions_list_for_detection.ps1
./security/default/0094_Disable_ads_Explorer_Advanced_ShowSyncProviderNotifications.ps1
./security/default/0101_Disable_xbox_Game_monitoring_service_xbgm.ps1
./security/default/0102.002_Disable_ads_SoftLandingEnabled.ps1
./security/default/0102.003_Disable_ads_RotatingLockScreenEnabled.ps1
./security/default/0102.004_Disable_ads_RotatingLockScreenOverlayEnabled.ps1
./security/default/0102.005_Disable_ads_ShowSyncProviderNotifications.ps1
#
./security/default/0364_get_chocolatey_iex.ps1
./security/default/0365_choco_upgrade_nmap.ps1
./security/default/0366_install_powershell7.ps1
./security/default/0368_block_msedge_telemetry.ps1
./security/default/0369_upgrade_powershell.ps1
#./security/default/0370_disable_tips.ps1
./security/default/0371_enable-feature_Microsoft-Windows-Subsystem-Linux.ps1
./security/default/0373_Disable_cool_data_tips_screen_log.ps1


#
./security/default/0385_Prevent_enabling_lock_screen_camera.ps1
./security/default/0386_Check_Data_execution_prevention_status.ps1
./security/default/0387_Enforce_Data_execution_Protection_for_almost_all_processes.ps1




############################################
# On demand . Enable if needed
############################################
#./security/default/0029_List_all_scheduled_tasks.ps1
#./security/default/0367_monitor_ip_trafic.ps1

