{ config, pkgs, lib, ... }:{
  imports = [
    ./modules/direnv.nix
  ];

  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    age
    ansible
    btop
    cilium-cli
    cmctl
    cowsay
    curl
    direnv
    dnsutils
    ethtool
    eza
    file
    firefox-wayland
    fluxcd
    fzf
    gawk
    gnupg
    gnused
    gnutar
    google-chrome
    hcloud
    helm
    iftop
    iotop
    ipcalc
    iperf3
    jetbrains.goland
    jq
    k9s
    kdePackages.oxygen
    krew
    ksshaskpass
    kubectl
    kubectl-cnpg
    kubectl-neat
    kubectl-validate
    kubectx
    kubelogin-oidc
    ldns
    lf
    lm_sensors
    lsof
    ltrace
    materia-kde-theme
    mtr
    nix-output-monitor
    nmap
    openvpn
    pciutils
    ripgrep
    rocketchat-desktop
    signal-desktop
    socat
    sops
    spotify
    strace
    sysstat
    talosctl
    telegram-desktop
    tmux
    tree
    unzip
    usbutils
    which
    xz
    yq-go
    zip
    zstd
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Sebastian Gaiser";
    userEmail = lib.mkDefault "sebastiangaiser@users.noreply.github.com";
    attributes = [
      "**/*.sops.yaml diff=sopsdiffer"
    ];
    ignores = [
      ".vscode/"
      ".idea/"
      ".env"
      ".envrc"
      "shell.nix"
      "*.iml"
    ];

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      tag = {
        sort = "version:refname";
      };
      diff = {
        # sops.textconv = "${pkgs.sops}/bin/sops -d --config /dev/null";
      };
    };

  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrains Mono";
      font-size = 10;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      k = "kubectl";
      kx = "kubectx";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#dell-xps13 && show-changes";
      update = "nix flake update --flake ~/nixos-config#dell-xps13 --impure && rebuild";
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
        "ssh"
        "tailscale"
        "tmux"
      ];
      theme = "robbyrussell";
    };
  };

  programs.vscode = {
    enable = true;
    #profiles.default = {
    #  userSettings = {
    #    "editor.tabSize" = 2;
    #    "files.autoSave" = "onFocusChange";
    #  };
    #};
  };

  programs.k9s = {
    enable = true;
    aliases = {
      aliases = {
        dp = "deployments";
        sec = "v1/secrets";
        jo = "jobs";
        cr = "clusterroles";
        crb = "clusterrolebindings";
        ro = "roles";
        rb = "rolebindings";
        np = "networkpolicies";
        rmqu = "users.rabbitmq.com";
        rmqv = "vhosts.rabbitmq.com";
        rmqq = "queues.rabbitmq.com";
        rmqpo = "policies.rabbitmq.com";
        rmqpe = "permissions.rabbit.com";
      };
    };
    plugin = {
      plugins = {
        # cert-manager
        cert-status = {
          shortCut = "Shift-S";
          confirm = false;
          description = "Certificate status";
          scopes = [ "certificates" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            "cmctl status certificate --context $CONTEXT -n $NAMESPACE $NAME |& less"
          ];
        };
        cert-renew = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Certificate renew";
          scopes = [ "certificates" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            "cmctl renew --context $CONTEXT -n $NAMESPACE $NAME |& less"
          ];
        };
        secret-inspect = {
          shortCut = "Shift-I";
          confirm = false;
          description = "Inspect secret";
          scopes = [ "secrets" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            "cmctl inspect secret --context $CONTEXT -n $NAMESPACE $NAME |& less"
          ];
        };
      };
    };
    settings = {
      skipLatestRevCheck = true;
    };
    skins = {};
    views = {};
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    #shell = ${pkgs.zsh}/bin/zsh;
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
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
	      theme = "__aurorae__svg__MateriaDark";
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
          # TODO add user icon...
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
      edgeBarrier = 0;
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
      timeout = 5;
      passwordRequired = true;
      passwordRequiredDelay = 5;
      lockOnStartup = false;
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
	      wallpaper = "/home/sebastian/nixos-config/images/nixos-wallpaper-catppuccin-mocha.png";
      };
    };

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
	      autoSuspend = {
          action = "shutDown";
          idleTimeout = 1000;
        };
        turnOffDisplay = {
          idleTimeout = 1000;
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };
      lowBattery = {
        whenLaptopLidClosed = "hibernate";
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
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
