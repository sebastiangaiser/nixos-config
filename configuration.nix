{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration/container.nix
    ./configuration/yubikey.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # Enable AMD P-State EPP for efficient CPU frequency scaling on Ryzen AI 300
    kernelParams = [ "amd_pstate=active" ];
  };

  networking = {
    hostName = "framework13";
    networkmanager = {
      enable = true;
      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };
  };

  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };
  console.keyMap = "de";

  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Compressed in-memory swap to handle memory pressure without disk I/O
  zramSwap.enable = true;

  services.fwupd.enable = true;
  # Periodic SSD TRIM to maintain performance and longevity
  services.fstrim.enable = true;
  # Distribute hardware interrupts across all CPU cores
  services.irqbalance.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.sebastian = {
    isNormalUser = true;
    description = "Sebastian";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config = {
    chromium.enableWideVine = true;
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      download-buffer-size = 524288000;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.chromium = {
    enable = true;
    extraOpts = {
    # Disable Google sign-in prompt in browser
    "BrowserSignin" = 0;
    # Disable Chrome Sync
    "SyncDisabled" = true;
    # Use Bitwarden instead
    "PasswordManagerEnabled" = false;
    # Disable credit card/payment method autofill
    "AutofillCreditCardEnabled" = false;
    # Disable address autofill
    "AutofillAddressEnabled" = false;
    # Disable search suggestions (avoids sending keystrokes to Google)
    "SearchSuggestEnabled" = false;
    # Disable reporting of usage/crash data
    "MetricsReportingEnabled" = false;

    # --- AI ---
    # Disable all generative AI features and prevent users from enabling them
    # 0=Disabled, 1=Allowed without data collection, 2=Allowed with data collection
    "GenAiDefaultSettings" = 0;
    # Disable "Help me write" AI feature
    "HelpMeWriteSettings" = 0;
    # Disable AI-powered history search
    "HistorySearchSettings" = 0;
    # Disable AI tab comparison
    "TabCompareSettings" = 0;
    # Disable AI features in DevTools
    "DevToolsGenAiSettings" = 0;
    # Disable Google Lens overlay
    "LensOverlaySettings" = 0;
    # Disable built-in AI APIs (window.ai / Prompt API)
    "BuiltInAIAPIsEnabled" = false;
    # Disable Gemini integration
    "GeminiSettings" = 0;

    # --- Privacy ---
    # Block third-party cookies
    "BlockThirdPartyCookies" = true;
    # Disable URL-keyed anonymized data collection
    "UrlKeyedAnonymizedDataCollectionEnabled" = false;
    # Disable network prediction/DNS prefetching (2=never prefetch)
    "NetworkPredictionOptions" = 2;
    # Disable alternate error pages (sends URLs to Google)
    "AlternateErrorPagesEnabled" = false;
    # Disable domain reliability monitoring
    "DomainReliabilityAllowed" = false;
    # Disable Privacy Sandbox ad topics
    "PrivacySandboxAdTopicsEnabled" = false;
    # Disable Privacy Sandbox ad measurement
    "PrivacySandboxAdMeasurementEnabled" = false;
    # Disable Privacy Sandbox site-enabled ads
    "PrivacySandboxSiteEnabledAdsEnabled" = false;
    # Disable Safe Browsing extended reporting (sends page data to Google)
    "SafeBrowsingExtendedReportingEnabled" = false;
    # Disable promotional tabs and content
    "PromotionalTabsEnabled" = false;
    # Disable shopping features and price tracking
    "ShoppingListEnabled" = false;
    # Disable media recommendations
    "MediaRecommendationsEnabled" = false;
    # Force HTTPS for all navigation
    "HttpsOnlyMode" = "force_enabled";

    # --- Telemetry & Feedback ---
    # Disable user feedback submissions to Google
    "UserFeedbackAllowed" = false;
    # Disable in-product feedback surveys
    "FeedbackSurveysEnabled" = false;
    # Disable Safe Browsing satisfaction surveys
    "SafeBrowsingSurveysEnabled" = false;
    # Disable online spell check service (sends typed text to Google)
    # Local Hunspell dictionaries (de_DE, en_US) continue to work offline
    "SpellCheckServiceEnabled" = false;
    # Disable Google Translate (sends page content to Google)
    "TranslateEnabled" = false;
    # Disable WebRTC event log upload to Google servers
    "WebRtcEventLogCollectionAllowed" = false;
    # Disable URL-keyed metrics reporting
    "UrlKeyedMetricsAllowed" = false;
    # Disable cloud reporting
    "CloudReportingEnabled" = false;
    # Disable cloud profile reporting
    "CloudProfileReportingEnabled" = false;
    # Disable A/B testing / field trials (2=disabled)
    "ChromeVariations" = 2;

    "SpellcheckEnabled" = true;
    "SpellcheckLanguage" = [
      "de"
      "en-US"
    ];
    };
  };

  programs = {
    zsh.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system = {
    stateVersion = "25.11";
  };
}
