{ config, pkgs, ... }:
{
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
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
                  "org.kde.plasma.removabledevices"
                  "org.kde.plasma.weather"
                ];
                hidden = [
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.mediacontroller"
                  "plasmashell_microphone"
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
          {
            name = "org.kde.plasma.userswitcher";
            config = {
              showFaceIcon = true;
              showUserName = false;
              showFullName = true;
              iconSize = 22;
            };
          }
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
          action = "sleep";
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
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      # TODO enable numlock on startup not working, yet
      # https://github.com/nix-community/plasma-manager/issues/117
      # kcminputrc.Keyboard.NumLock.value = 0;
      kwinrc = {
        "org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
        "Desktops"."Number" = {
          value = 1;
          # Forces kde to not change this value (even through the settings app).
          immutable = true;
        };
      };
    };
  };
}
