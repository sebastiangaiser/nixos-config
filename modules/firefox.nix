{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
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
      };
    };
  };
}
