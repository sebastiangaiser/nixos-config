{ 
  config, 
  pkgs,
  ... 
}:

{
  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    curl
    lf
    sops
    age
    ansible
    kubectl
    kubectl-neat
    helm
    fluxcd
    hcloud
    openvpn
    tmux
    signal-desktop
    direnv
    spotify
    jetbrains.goland
    firefox-wayland
    google-chrome
    k9s
    materia-kde-theme
    kdePackages.oxygen
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Sebastian Gaiser";
    userEmail = "sebastiangaiser@users.noreply.github.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      k = "kubectl";
      kx = "kubectx";
      rebuild = "sudo nixos-rebuild switch && show-changes";
      update = "nix flake update --flake ~/NyxOS --impure && rebuild";
      cleanup = "sudo nix store optimise && sudo nix-collect-garbage -d";
      pm-reset = "rm ~/.local/share/plasma-manager/last_run_* && ~/.local/share/plasma-manager/run_all.sh";
      pm-rebuild = "rebuild && pm-reset";
      show-changes = "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
    };
    history.size = 100000000;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
	"golang"
	"kind"
	"kubectl"
	"kubectx"
	"pip"
	"podman"
	"ssh"
	"tailscale"
        "tmux"
      ];
      theme = "robbyrussell";
    };
  };

  programs.vscode = {
    enable = true;
  };

  programs.plasma = {
    enable = true;
    input = {
      keyboard = {
        numlockOnStartup = "unchanged";
      };
    };

    workspace = {
      clickItemTo = "select";
      colorScheme = "MateriaDark";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor.theme = "Oxygen_White";
      theme = "Materia";
      iconTheme = "Papirus-Dark";
      wallpaper = "/home/sebastian/nixos-config/images/nixos-wallpaper-catppuccin-mocha.png";
      soundTheme = "ocean";
      splashScreen = {
        theme = "None";
      };
    };

    windows = {
      allowWindowsToRememberPositions = true;
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    panels = [
      {
        location = "top";
        height = 24;
	floating = false;
        screen = "all";
        widgets = [
	  {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
	  "org.kde.plasma.appmenu"
	  "org.kde.plasma.panelspacer"
	  "org.kde.plasma.systemmonitor.diskusage"
	  "org.kde.plasma.systemmonitor.memory"
	  "org.kde.plasma.systemmonitor.cpucore"
	  {
            systemTray = {
	      items = {
	        showAll = false;
                shown = [
		  "org.kde.plasma.volume"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
		  "org.kde.plasma.brighness"
                  "org.kde.plasma.displays"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.removabledevices"
		  "org.kde.plasma.weather"
                ];
	      };
            };
          }
	  {
            digitalClock = {
              calendar = {
	        showWeekNumbers = true;
	        firstDayOfWeek = "monday";
	      };
              time = {
	        showSeconds = "onlyInTooltip";
	        format = "24h";
	      };
	      date = {
                enable = true;
                position = "belowTime";
              };
            };
          }
	  "org.kde.plasma.userswitcher"
	  #{
	  #  userSwitcher = {
	  #  };
	  #}
          {
            name = "org.kde.plasma.lock_logout";
            config.General = {
              showLock = true;
              showShutdown = true;
              showSwitchUser = false;
              showLogout = false;
              showSleep = false;
              showRestart = false;
              showSuspend = false;
              showHibernate = false;
            };
	  }
	];
      }
    ];

    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };

    shortcuts = {
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+Ctrl+Alt+L"
        ];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
      };
    };

    kwin = {
      edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
      cornerBarrier = false;
      nightLight = {
        enable = true;
        mode = "times";
        time = {
          morning = "08:00";
          evening = "18:00";
        };
        temperature = {
          day = 6500;
          night = 4000;
        };
        transitionTime = 30;
      };
    };

    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
      timeout = 10;
      passwordRequired = true;
      passwordRequiredDelay = 5;
      lockOnStartup = false;
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
	wallpaper = "/home/sebastian/nixos-config/images/nixos-wallpaper-catppuccin-mocha.png";
      };
    };

    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
      "kwinrc"."Desktops"."Number" = {
        value = 1;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

