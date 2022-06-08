::Disable MSDT URL Protocol
::CVE-2022-30190
::https://msrc-blog.microsoft.com/2022/05/30/guidance-for-cve-2022-30190-microsoft-support-diagnostic-tool-vulnerability/
reg export HKEY_CLASSES_ROOT\ms-msdt CVE-2022-30190
reg delete HKEY_CLASSES_ROOT\ms-msdt /f