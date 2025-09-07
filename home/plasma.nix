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

      # # Window decorations (KWin/Aurorae)
      # windowDecorations = {
      #   theme = "__aurorae__svg__Utterly-Round-Dark";
      #   library = "org.kde.kwin.aurorae";
      # };

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
        temperature.night = 3400;
      };

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

    hotkeys.commands = {

    };


    shortcuts = {
      ## 🔊 System Volume / Brightness
      "kmix"."increase_volume" = ["Meta+PgUp" "Meta+PgUp,Increase Volume"];
      "kmix"."decrease_volume" = ["Meta+PgDown" "Meta+PgDown,Decrease Volume"];
      "kmix"."mute" = ["Meta+M" "Meta+M,Mute Audio"];
      "kmix"."mic_mute" = ["Meta+Shift+M" "Meta+Shift+M,Mute Microphone"];

      ## 🔒 Session
      "ksmserver"."Lock Session" = ["Meta+L" "Screensaver,Meta+L"];
      "ksmserver"."Log Out" = ["Meta+Esc" "Meta+Esc,Show Logout Screen"];

      ## 🪟 Window Management
      "kwin"."Overview" = ["Meta+Tab" "Meta+Tab,Toggle Overview"];
      "kwin"."ExposeClass" = ["Meta+W" "Meta+W,Present Windows of Same App"];
      "kwin"."Walk Through Windows" = ["Alt+Tab" "Alt+Tab,Walk Through Windows"];
      "kwin"."Window Close" = ["Alt+F4" "Alt+F4,Close Window"];
      "kwin"."Window Minimize" = ["Meta+Down" "Meta+Down,Minimize Window"];
      "kwin"."Window Maximize" = ["Meta+Up" "Meta+Up,Maximize Window"];
      "kwin"."Window Quick Tile Left" = ["Meta+Left" "Meta+Left,Quick Tile Left"];
      "kwin"."Window Quick Tile Right" = ["Meta+Right" "Meta+Right,Quick Tile Right"];
      "kwin"."Window Quick Tile Top" = ["Meta+Shift+Up" "Meta+Shift+Up,Quick Tile Top"];
      "kwin"."Window Quick Tile Bottom" = ["Meta+Shift+Down" "Meta+Shift+Down,Quick Tile Bottom"];
      "kwin"."Kill Window" = ["Meta+Ctrl+Esc" "Meta+Ctrl+Esc,Kill Window"];

      ## 🖥️ Virtual Desktops
      "kwin"."Switch One Desktop to the Left" = ["Meta+Ctrl+Left" "Meta+Ctrl+Left,Switch One Desktop Left"];
      "kwin"."Switch One Desktop to the Right" = ["Meta+Ctrl+Right" "Meta+Ctrl+Right,Switch One Desktop Right"];
      "kwin"."Window One Desktop to the Left" = ["Meta+CSStrl+Shift+Left" "Meta+Ctrl+Shift+Left,Move Window to Desktop Left"];
      "kwin"."Window One Desktop to the Right" = ["Meta+Ctrl+Shift+Right" "Meta+Ctrl+Shift+Right,Move Window to Desktop Right"];

      ## ⌨️ App Launchers
      "plasmashell"."activate application launcher" = ["Meta" "Meta,Activate Application Launcher"];
      "plasmashell"."activate task manager entry 1" = ["Meta+1" "Meta+1,Activate Task Manager Entry 1"];
      "plasmashell"."activate task manager entry 2" = ["Meta+2" "Meta+2,Activate Task Manager Entry 2"];
      "plasmashell"."activate task manager entry 3" = ["Meta+3" "Meta+3,Activate Task Manager Entry 3"];
      "plasmashell"."activate task manager entry 4" = ["Meta+4" "Meta+4,Activate Task Manager Entry 4"];
      "plasmashell"."activate task manager entry 5" = ["Meta+5" "Meta+5,Activate Task Manager Entry 5"];
      "plasmashell"."activate task manager entry 6" = ["Meta+6" "Meta+6,Activate Task Manager Entry 6"];
      "plasmashell"."activate task manager entry 7" = ["Meta+7" "Meta+7,Activate Task Manager Entry 7"];
      "plasmashell"."activate task manager entry 8" = ["Meta+8" "Meta+8,Activate Task Manager Entry 8"];
      "plasmashell"."activate task manager entry 9" = ["Meta+9" "Meta+9,Activate Task Manager Entry 9"];

      ## 🖼️ Clipboard & Tools
      "plasmashell"."show-on-mouse-pos" = ["Meta+V" "Meta+V,Show Clipboard at Mouse Position"];
      "services/net.local.ocr-kde.sh.desktop"."_launch" = "Meta+Shift+T";
      "services/org.gnome.Nautilus.desktop"."_launch" = "Meta+E";
      "services/systemsettings.desktop"."_launch" = "Meta+I";
      "plasma-desktop"."_launch_terminal" = "Meta+T";
      "plasma-desktop"."_launch_browser" = "Meta+B";

      ## 🎵 Media Control
      "mediacontrol"."playpausemedia" = ["Meta+P" "Meta+P,Play/Pause"];
      "mediacontrol"."nextmedia" = ["Meta+Alt+Right" "Meta+Alt+Right,Next Track"];
      "mediacontrol"."previousmedia" = ["Meta+Alt+Left" "Meta+Alt+Left,Previous Track"];
      "mediacontrol"."stopmedia" = ["Meta+Alt+Down" "Meta+Alt+Down,Stop Media"];

      ## ☀️ Brightness (if laptop)
      "powerdevil"."increase_brightness" = ["Meta+Shift+PgUp" "Meta+Shift+PgUp,Increase Brightness"];
      "powerdevil"."decrease_brightness" = ["Meta+Shift+PgDown" "Meta+Shift+PgDown,Decrease Brightness"];
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
                timeZoneDisplay = "Code";             # "Code" | "City" | "Offset"
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