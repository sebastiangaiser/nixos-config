{ config, pkgs, ... }:
{
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
}
