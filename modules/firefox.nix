{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = {
        # uBlock Origin (full MV2 version — more powerful than uBlock Origin Lite in Chromium)
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # Bitwarden Password Manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        # KDE Plasma Browser Integration
        "plasma-browser-integration@kde.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
        };
      };
    };
    profiles.default = {
      settings = {
        # --- Telemetry ---
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;

        # --- Studies & Experiments ---
        # Disable Mozilla studies (remote code execution for experiments)
        "app.shield.optoutstudies.enabled" = false;
        # Disable Normandy/Shield remote settings
        "app.normandy.enabled" = false;

        # --- Sponsored Content ---
        # Disable Pocket integration
        "extensions.pocket.enabled" = false;
        # Disable sponsored content on new tab page
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # Disable sponsored suggestions in address bar
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.sponsoredTopSites" = false;

        # --- Tracking & Pings ---
        # Disable hyperlink ping tracking
        "browser.send_pings" = false;
        # Disable Beacon API (used for tracking on page unload)
        "beacon.enabled" = false;
        # Disable Firefox discovery/recommendations pane in add-ons
        "browser.discovery.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # --- Tracking Protection ---
        # Enable strict Enhanced Tracking Protection
        "browser.contentblocking.category" = "strict";

        # --- Autofill & Passwords (matching Chromium policies) ---
        # Don't save passwords - use Bitwarden instead
        "signon.rememberSignons" = false;
        # Disable credit card autofill
        "extensions.formautofill.creditCards.enabled" = false;
        # Disable address autofill
        "extensions.formautofill.addresses.enabled" = false;

        # --- Search Suggestions ---
        # Disable sending keystrokes to search engine
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;

        # --- Sync ---
        # Disable Firefox Accounts/Sync - using Bitwarden
        "identity.fxaccounts.enabled" = false;

        # --- Network Prefetching (matching Chromium NetworkPredictionOptions=2) ---
        # Disable link prefetching
        "network.prefetch-next" = false;
        # Disable DNS prefetching
        "network.dns.disablePrefetch" = true;
        # Disable network predictor
        "network.predictor.enabled" = false;
        # Disable speculative connections
        "network.http.speculative-parallel-limit" = 0;

        # --- HTTPS Only (matching Chromium HttpsOnlyMode=force_enabled) ---
        "dom.security.https_only_mode" = true;

        # --- Translation ---
        # Disable built-in translation (sends page content to Mozilla servers)
        "browser.translations.enable" = false;

        # --- WebRTC ---
        # Prevent WebRTC from leaking local IP address
        "media.peerconnection.ice.no_host" = true;

        # --- Geolocation ---
        # Disable geolocation API
        "geo.enabled" = false;

        # --- Safe Browsing ---
        # Disable sending download metadata to Google
        "browser.safebrowsing.downloads.remote.enabled" = false;
      };
    };
  };
}
