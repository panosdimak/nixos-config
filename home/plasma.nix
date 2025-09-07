{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fluent-icon-theme
    utterly-nord-plasma
    utterly-round-plasma-style
    kde-rounded-corners
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    workspace = {
      lookAndFeel = "Utterly-Nord";
      theme = "Utterly-Round";
      iconTheme = "Fluent";
      colorScheme = "UtterlyNord";

      enableMiddleClickPaste = false;
    };

    input = {
      keyboard.numlockOnStartup = "on";
    };

    fonts = {
      general     = { family = "Inter"; pointSize = 10; };
      fixedWidth  = { family = "Inter"; pointSize = 10; };
      menu        = { family = "Inter"; pointSize = 10; };
      toolbar     = { family = "Inter"; pointSize = 10; };
      small       = { family = "Inter"; pointSize = 8;  };   
      windowTitle = { family = "Inter"; pointSize = 10; };
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    powerdevil = {
      AC.autoSuspend.action = "nothing";
      AC.dimDisplay.enable = false;
      AC.powerButtonAction = "sleep";
      AC.powerProfile = "performance";
      AC.turnOffDisplay.idleTimeout = "never";
    };
    
    kwin = {
      nightLight = {
        enable = true;
        location = {
          latitude = "37.402492843511446";
          longitude = "22.55550986842104";
        };
        mode = "location";
        temperature.night = 3200;
      };

      virtualDesktops.number = 4;

      effects = {
        blur = {
          enable = true;
          strength = 10;
          noiseStrength = 4;
        };

        translucency = {
          enable = true;
        };
      };
    };

    shortcuts = {
      kmix = {
        increase_volume = "Meta+PgUp";
        decrease_volume = "Meta+PgDown";
        mute = "Meta+M";
        mic_mute = "Meta+Shift+M";
      };

      ksmserver = {
        "Lock Session" = "Meta+L";
        "Log Out" = "Meta+Esc";
      };

      kwin = {
        # Window Management
        Overview = "Meta+Tab";
        ExposeClass = "Meta+W";
        "Walk Through Windows" = "Alt+Tab";
        "Window Close" = "Alt+F4";
        "Window Minimize" = "Meta+Down";
        "Window Maximize" = "Meta+Up";
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Shift+Up";
        "Window Quick Tile Bottom" = "Meta+Shift+Down";
        "Kill Window" = "Meta+Ctrl+Esc";

        # Virtual Desktops
        "Switch One Desktop to the Left" = "Meta+Ctrl+Left";
        "Switch One Desktop to the Right" = "Meta+Ctrl+Right";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
      };

      plasmashell = {      
        # System Controls
        "toggle do not disturb" = "Meta+Shift+D";
        show-on-mouse-pos = "Meta+V";
      };

      mediacontrol = {
        playpausemedia = "Meta+P";
        nextmedia = "Meta+Alt+Right";
        previousmedia = "Meta+Alt+Left";
        stopmedia = "Meta+Alt+Down";
      };

      # Apps & Tools
      "services/com.mitchellh.ghostty.desktop" = { "_launch" = "Meta+T"; };
      "services/net.local.ocr-kde.sh.desktop"  = { "_launch" = "Meta+Shift+T"; };
      "services/org.gnome.Nautilus.desktop"    = { "_launch" = "Meta+E"; };
      "services/systemsettings.desktop"        = { "_launch" = "Meta+I"; };
      "services/zen-twilight.desktop"          = { "_launch" = "Meta+B"; };
      "services/code.desktop"                  = { "_launch" = "Meta+C"; };
      "services/obsidian.desktop"              = { "_launch" = "Meta+O"; };

      # Brightness (if laptop)
      powerdevil = {
        increase_brightness = "Meta+Shift+PgUp";
        decrease_brightness = "Meta+Shift+PgDown";
      };
    };

     panels = [
      {
        location = "bottom";
        height = 48;
        opacity = "translucent";


        widgets = [
          { name = "org.kde.plasma.kickoff"; }

          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.gnome.Nautilus.desktop"
                  "applications:zen-twilight.desktop"
                  "applications:com.mitchellh.ghostty.desktop"          
                  "applications:code.desktop"
                  "applications:obsidian.desktop"
                  "applications:spotify.desktop"
                  "applications:vesktop.desktop"
                ];
              };
            };
          }

          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                showDate = true;
                dateDisplayFormat = "BelowTime";
                dateFormat = "custom";
                customDateFormat = "ddd d MMM";
                autoFontAndSize = false;
                fontFamily = "Inter";
                fontSize = 14;
                fontStyleName = "Regular";
                fontWeight = 400;
              };

              Time = {
                use24hFormat = false;
                showSeconds = "InTooltip";
                showTimeZone = "WhenDifferent";
                timeZoneDisplay = "Code";
              };
            };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    configFile = {
      kdeglobals = {
        General = {
          AccentColor = "#b875dc";
          accentColorFromWallpaper = false;

          TerminalApplication = "ghostty";
          BrowserApplication = "zen-twilight";
        
          XftHintStyle = "hintslight";
          XftSubPixel = "none";
        };
      };

      kscreenlockerrc = { 
        Daemon = {
          Autolock = false;
          LockGrace = 0;
          Timeout = 0;
        };

        "Greeter/LnF/General" = {
          showMediaControls = false;
        };
      };
      
      kwinrc = {
        Plugins = {
          screenEdgesEnabled = false;
          kwin4_effect_geometry_changeEnabled = true;
          translucencyEnabled = true;
        };

        "Round-Corners" = {
          ActiveOutlineAlpha = 255;
          ActiveOutlineUseCustom = false;
          ActiveOutlineUsePalette = true;
          DisableOutlineTile = false;
          DisableRoundTile = false;
          InactiveCornerRadius = 8;
          InactiveOutlineAlpha = 0;
          InactiveSecondOutlineThickness = 0;
          OutlineThickness = 1;
          SecondOutlineThickness = 0;
          Size = 8;
        };

        Effect-translucency = {
          ComboboxPopups = 95;
          Dialogs = 96;
          Menus = 96;
          MoveResize = 89;
        };

        Tiling = {
          padding = 4;
        };

        Windows = {
          ElectricBorders = 1;
        };

        "org.kde.kdecoration2" = {
          BorderSize = "None";
          BorderSizeAuto = false;
          ButtonsOnLeft = "NFB";
          ButtonsOnRight = "IAX";
        };
      };
    };
  };
}