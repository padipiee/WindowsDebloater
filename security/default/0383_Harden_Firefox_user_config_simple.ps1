# Define the path to the Firefox profile folders

# Check 0201_Enforce_Firefox_config.txt for a similar hardening script

# prefs.js is read by Firefox

# user.js is read by Firefox - all preferences in the
# user.js file are copied to the prefs.js file and any preferences that
# are duplicated in both files are overridden by those in user.js -
# prefs.js is then used to generate what you see in about:config
# ref https://github.com/arkenfox/user.js/blob/master/user.js

$FirefoxProfilePath = "C:\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release"
Write-Host "[0384_Harden_Firefox_user_config_simple] Configuration in $FirefoxProfilePath user.js file."

# Define the telemetry settings to configure
$MySettings = @(
    'user_pref("signon.autofillForms", false);',
    'user_pref("signon.formlessCapture.enabled", false);',
    'user_pref("signon.rememberSignons", false);',
    'user_pref("signon.rememberSignons.visibilityToggle", false);',
    'user_pref("signon.showAutoCompleteFooter", false);',
    'user_pref("privacy.userContext.enabled", true);',
    'user_pref("privacy.userContext.ui.enabled", true);',
    'user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);',
    'user_pref("network.IDN_show_punycode", true);',
    'user_pref("browser.download.useDownloadDir", false);',
    'user_pref("browser.download.alwaysOpenPanel", false);',
    'user_pref("browser.download.manager.addToRecentDocs", false);',
    'user_pref("browser.contentblocking.category", "strict");',
    'user_pref("privacy.sanitize.sanitizeOnShutdown", true);',
    'user_pref("privacy.clearOnShutdown.cache", true);',
    'user_pref("privacy.clearOnShutdown.downloads", true);',
    'user_pref("privacy.clearOnShutdown.formdata", true);',
    'user_pref("privacy.clearOnShutdown.history", true);',
    'user_pref("privacy.clearOnShutdown.sessions", true);',
    'user_pref("privacy.resistFingerprinting", true); ',
    'user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);',
    'user_pref("browser.download.always_ask_before_handling_new_types", true);',
    'user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);',
    'user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);',
    'user_pref("browser.newtabpage.activity-stream.showSponsored", false);',
    'user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);',
    'user_pref("browser.newtabpage.activity-stream.default.sites", "");',    
    'user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);',
    'user_pref("browser.newtabpage.activity-stream.telemetry", false);',
    'user_pref("app.shield.optoutstudies.enabled", false);',
    'user_pref("network.prefetch-next", false);',
    'user_pref("browser.search.suggest.enabled", false);',
    'user_pref("browser.urlbar.suggest.searches", false);',
    'user_pref("browser.urlbar.trending.featureGate", false);',
    'user_pref("browser.urlbar.addons.featureGate", false);',
    'user_pref("browser.urlbar.mdn.featureGate", false);',
    'user_pref("browser.urlbar.pocket.featureGate", false);',
    'user_pref("browser.urlbar.weather.featureGate", false);',
    'user_pref("browser.formfill.enable", false);',
    'user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);',
    'user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);',
    'user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);',
    'user_pref("breakpad.reportURL", "");',
    'user_pref("browser.tabs.crashReporting.sendReport", false); ',
    'user_pref("geo.provider.ms-windows-location", false);',
    'user_pref("datareporting.policy.dataSubmissionEnabled", false);',
    'user_pref("datareporting.healthreport.uploadEnabled", false);',
    'user_pref("browser.ping-centre.telemetry", false);',
    'user_pref("toolkit.telemetry.archive.enabled", false);',
    'user_pref("toolkit.telemetry.bhrPing.enabled", false);',
    'user_pref("toolkit.telemetry.coverage.opt-out", true);',
    'user_pref("toolkit.coverage.opt-out", true);',
    'user_pref("toolkit.telemetry.enabled", false);',
    'user_pref("toolkit.coverage.endpoint.base", "");',
    'user_pref("browser.ping-centre.telemetry", false);',
    'user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);',
    'user_pref("toolkit.telemetry.newProfilePing.enabled", false);',
    'user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);',
    'user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);',
    'user_pref("toolkit.telemetry.server", "data:,");',
    'user_pref("toolkit.telemetry.unified", false);',
    'user_pref("browser.startup.homepage", "https://www.google.com/");',
    'user_pref("browser.newtab.url", "https://www.startpage.com/");',
    'user_pref("extensions.formautofill.addresses.enabled", false);',
    'user_pref("extensions.formautofill.creditCards.enabled", false);',
    'user_pref("toolkit.telemetry.updatePing.enabled", false);'
    
)

# Resolve the wildcard path to actual directories
$ResolvedPaths = Resolve-Path $FirefoxProfilePath

# Configure the  settings
$ResolvedPaths | ForEach-Object {
    $userJsPath = Join-Path $_.Path "user.js"
    $existingContent = Get-Content -Path $userJsPath -ErrorAction SilentlyContinue

    $MySettings | ForEach-Object {
        if ($existingContent -contains $_) {
            Write-Host "[0384_Harden_Firefox_user_config_simple] Parameter: $_ - Status: On Target"
        } else {
            Add-Content -Path $userJsPath -Value $_
            Write-Host "[0384_Harden_Firefox_user_config_simple] Parameter: $_ - Status: Added"
        }
    }
}