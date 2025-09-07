{
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
    # locale = {
      # formats.LANG = "en_US.UTF-8";
    # };

    # kdeglobals.General = {
    #   TerminalApplication = "ghostty";
    #   TerminalService     = "com.mitchellh.ghostty.desktop";
    # };


    shortcuts = {
      "kaccess"."Toggle Screen Reader On and Off" = ["Meta+Alt+S" "Meta+Alt+S,Toggle Screen Reader On and Off"];

      "kmix"."decrease_microphone_volume" = ["Microphone Volume Down" "Microphone Volume Down,Decrease Microphone Volume"];
      "kmix"."decrease_volume" = ["Volume Down" "Alt+Num+-,Volume Down,Decrease Volume"];
      "kmix"."decrease_volume_small" = ["Shift+Volume Down" "Shift+Volume Down,Decrease Volume by 1%"];
      "kmix"."increase_microphone_volume" = ["Microphone Volume Up" "Microphone Volume Up,Increase Microphone Volume"];
      "kmix"."increase_volume" = ["Alt+Num++" "Volume Up,Volume Up,Increase Volume"];
      "kmix"."increase_volume_small" = ["Shift+Volume Up" "Shift+Volume Up,Increase Volume by 1%"];
      "kmix"."mic_mute" = ["Microphone Mute" "Meta+Volume Mute,Microphone Mute" "Meta+Volume Mute,Mute Microphone"];
      "kmix"."mute" = ["Volume Mute" "Volume Mute,Mute"];

      "ksmserver"."Halt Without Confirmation" = "none,,Shut Down Without Confirmation";
      "ksmserver"."Lock Session" = ["Meta+L" "Screensaver,Meta+L" "Screensaver,Lock Session"];
      "ksmserver"."Log Out" = ["Ctrl+Alt+Del" "Ctrl+Alt+Del,Show Logout Screen"];
      "ksmserver"."Log Out Without Confirmation" = "none,,Log Out Without Confirmation";
      "ksmserver"."LogOut" = "none,,Log Out";
      "ksmserver"."Reboot" = "none,,Reboot";
      "ksmserver"."Reboot Without Confirmation" = "none,,Reboot Without Confirmation";
      "ksmserver"."Shut Down" = "none,,Shut Down";

      "kwin"."Activate Window Demanding Attention" = ["Meta+Ctrl+A" "Meta+Ctrl+A,Activate Window Demanding Attention"];
      "kwin"."Cycle Overview" = "none,none,Cycle through Overview and Grid View";
      "kwin"."Cycle Overview Opposite" = "none,none,Cycle through Grid View and Overview";
      "kwin"."Decrease Opacity" = "none,,Decrease Opacity of Active Window by 5%";
      "kwin"."Edit Tiles" = ["Meta+T" "Meta+T,Toggle Tiles Editor"];
      "kwin"."Expose" = ["Ctrl+F9" "Ctrl+F9,Toggle Present Windows (Current desktop)"];
      "kwin"."ExposeAll" = ["Ctrl+F10" "Launch (C),Ctrl+F10" "Launch (C),Toggle Present Windows (All desktops)"];
      "kwin"."ExposeClass" = ["Ctrl+F7" "Ctrl+F7,Toggle Present Windows (Window class)"];
      "kwin"."ExposeClassCurrentDesktop" = "none,none,Toggle Present Windows (Window class on current desktop)";
      "kwin"."Grid View" = ["Meta+G" "Meta+G,Toggle Grid View"];
      "kwin"."Increase Opacity" = "none,,Increase Opacity of Active Window by 5%";
      "kwin"."Kill Window" = ["Meta+Ctrl+Esc" "Meta+Ctrl+Esc,Kill Window"];
      "kwin"."Move Tablet to Next Output" = "none,none,Move the tablet to the next output";
      "kwin"."MoveMouseToCenter" = ["Meta+F6" "Meta+F6,Move Mouse to Center"];
      "kwin"."MoveMouseToFocus" = ["Meta+F5" "Meta+F5,Move Mouse to Focus"];
      "kwin"."MoveZoomDown" = "none,none,Move Zoomed Area Downwards";
      "kwin"."MoveZoomLeft" = "none,none,Move Zoomed Area to Left";
      "kwin"."MoveZoomRight" = "none,none,Move Zoomed Area to Right";
      "kwin"."MoveZoomUp" = "none,none,Move Zoomed Area Upwards";
      "kwin"."Overview" = ["Meta+Tab" "Meta+Tab,Toggle Overview"];
      "kwin"."Show Desktop" = ["Meta+D" "Meta+D,Peek at Desktop"];
      "kwin"."Switch One Desktop Down" = ["Meta+Ctrl+Down" "Meta+Ctrl+Down,Switch One Desktop Down"];
      "kwin"."Switch One Desktop Up" = ["Meta+Ctrl+Up" "Meta+Ctrl+Up,Switch One Desktop Up"];
      "kwin"."Switch One Desktop to the Left" = ["Meta+Ctrl+Left" "Meta+Ctrl+Left,Switch One Desktop to the Left"];
      "kwin"."Switch One Desktop to the Right" = ["Meta+Ctrl+Right" "Meta+Ctrl+Right,Switch One Desktop to the Right"];
      "kwin"."Switch Window Down" = ["Meta+Alt+Down" "Meta+Alt+Down,Switch to Window Below"];
      "kwin"."Switch Window Left" = ["Meta+Alt+Left" "Meta+Alt+Left,Switch to Window to the Left"];
      "kwin"."Switch Window Right" = ["Meta+Alt+Right" "Meta+Alt+Right,Switch to Window to the Right"];
      "kwin"."Switch Window Up" = ["Meta+Alt+Up" "Meta+Alt+Up,Switch to Window Above"];
      "kwin"."Switch to Desktop 1" = ["Ctrl+F1" "Ctrl+F1,Switch to Desktop 1"];
      "kwin"."Switch to Desktop 2" = ["Ctrl+F2" "Ctrl+F2,Switch to Desktop 2"];
      "kwin"."Switch to Desktop 3" = ["Ctrl+F3" "Ctrl+F3,Switch to Desktop 3"];
      "kwin"."Switch to Desktop 4" = ["Ctrl+F4" "Ctrl+F4,Switch to Desktop 4"];
      "kwin"."Toggle Night Color" = "none,none,Suspend/Resume Night Light";
      "kwin"."Walk Through Windows" = ["Alt+Tab" "Alt+Tab,Walk Through Windows"];
      "kwin"."Walk Through Windows (Reverse)" = ["Alt+Shift+Tab,Meta+Shift+Tab" "Alt+Shift+Tab,Walk Through Windows (Reverse)"];
      "kwin"."Walk Through Windows of Current Application" = ["Alt+`" "Meta+`" "Alt+`,Walk Through Windows of Current Application"];
      "kwin"."Walk Through Windows of Current Application (Reverse)" = ["Alt+~" "Meta+~" "Alt+~,Walk Through Windows of Current Application (Reverse)"];
      "kwin"."Window Close" = ["Alt+F4" "Alt+F4,Close Window"];
      "kwin"."Window Maximize" = ["Meta+PgUp" "Meta+PgUp,Maximize Window"];
      "kwin"."Window Minimize" = ["Meta+PgDown" "Meta+PgDown,Minimize Window"];
      "kwin"."Window One Desktop Down" = ["Meta+Ctrl+Shift+Down" "Meta+Ctrl+Shift+Down,Window One Desktop Down"];
      "kwin"."Window One Desktop Up" = ["Meta+Ctrl+Shift+Up" "Meta+Ctrl+Shift+Up,Window One Desktop Up"];
      "kwin"."Window One Desktop to the Left" = ["Meta+Ctrl+Shift+Left" "Meta+Ctrl+Shift+Left,Window One Desktop to the Left"];
      "kwin"."Window One Desktop to the Right" = ["Meta+Ctrl+Shift+Right" "Meta+Ctrl+Shift+Right,Window One Desktop to the Right"];
      "kwin"."Window Operations Menu" = ["Alt+F3" "Alt+F3,Window Operations Menu"];
      "kwin"."Window Quick Tile Bottom" = ["Meta+Down" "Meta+Down,Quick Tile Window to the Bottom"];
      "kwin"."Window Quick Tile Left" = ["Meta+Left" "Meta+Left,Quick Tile Window to the Left"];
      "kwin"."Window Quick Tile Right" = ["Meta+Right" "Meta+Right,Quick Tile Window to the Right"];
      "kwin"."Window Quick Tile Top" = ["Meta+Up" "Meta+Up,Quick Tile Window to the Top"];
      "kwin"."Window to Desktop 2" = "none,,Window to Desktop 2"; # explicitly none in backup
      "kwin"."Window to Next Screen" = ["Meta+Shift+Right" "Meta+Shift+Right,Move Window to Next Screen"];
      "kwin"."Window to Previous Screen" = ["Meta+Shift+Left" "Meta+Shift+Left,Move Window to Previous Screen"];
      "kwin"."disableInputCapture" = ["Meta+Shift+Esc" "Meta+Shift+Esc,Disable Active Input Capture"];
      "kwin"."view_actual_size" = ["Meta+0" "Meta+0,Zoom to Actual Size"];
      "kwin"."view_zoom_in" = ["Meta++" "Meta+=,Meta++" "Meta+=,Zoom In"];
      "kwin"."view_zoom_out" = ["Meta+-" "Meta+-,Zoom Out"];

      "mediacontrol"."nextmedia" = ["Media Next" "Media Next,Media playback next"];
      "mediacontrol"."pausemedia" = ["Media Pause" "Media Pause,Pause media playback"];
      "mediacontrol"."playpausemedia" = ["Media Play" "Media Play,Play/Pause media playback"];
      "mediacontrol"."previousmedia" = ["Media Previous" "Media Previous,Media playback previous"];
      "mediacontrol"."stopmedia" = ["Media Stop" "Media Stop,Stop media playback"];

      "plasmashell"."activate application launcher" = ["Meta" "Alt+F1,Meta" "Alt+F1,Activate Application Launcher"];
      "plasmashell"."activate task manager entry 1" = ["Meta+1" "Meta+1,Activate Task Manager Entry 1"];
      "plasmashell"."activate task manager entry 2" = ["Meta+2" "Meta+2,Activate Task Manager Entry 2"];
      "plasmashell"."activate task manager entry 3" = ["Meta+3" "Meta+3,Activate Task Manager Entry 3"];
      "plasmashell"."activate task manager entry 4" = ["Meta+4" "Meta+4,Activate Task Manager Entry 4"];
      "plasmashell"."activate task manager entry 5" = ["Meta+5" "Meta+5,Activate Task Manager Entry 5"];
      "plasmashell"."activate task manager entry 6" = ["Meta+6" "Meta+6,Activate Task Manager Entry 6"];
      "plasmashell"."activate task manager entry 7" = ["Meta+7" "Meta+7,Activate Task Manager Entry 7"];
      "plasmashell"."activate task manager entry 8" = ["Meta+8" "Meta+8,Activate Task Manager Entry 8"];
      "plasmashell"."activate task manager entry 9" = ["Meta+9" "Meta+9,Activate Task Manager Entry 9"];
      "plasmashell"."cycle-panels" = ["Meta+Alt+P" "Meta+Alt+P,Move keyboard focus between panels"];
      "plasmashell"."clipboard_action" = ["Meta+Ctrl+X" "Meta+Ctrl+X,Automatic Action Popup Menu"];
      "plasmashell"."manage activities" = ["Meta+Q" "Meta+Q,Show Activity Switcher"];
      "plasmashell"."next activity" = ["Meta+A" "none,Walk through activities"];
      "plasmashell"."previous activity" = ["Meta+Shift+A" "none,Walk through activities (Reverse)"];
      "plasmashell"."show dashboard" = ["Ctrl+F12" "Ctrl+F12,Show Desktop"];
      "plasmashell"."show-on-mouse-pos" = ["Meta+V" "Meta+V,Show Clipboard Items at Mouse Position"];
      "plasmashell"."stop current activity" = ["Meta+S" "Meta+S,Stop Current Activity"];

      "services/com.mitchellh.ghostty.desktop"."_launch" = "Ctrl+Alt+T";
      "services/net.local.ocr-kde.sh.desktop"."_launch" = "Meta+Shift+T";
      "services/org.gnome.Nautilus.desktop"."_launch" = "Meta+E";
      "services/systemsettings.desktop"."_launch" = "Meta+I";
      "services/org.kde.dolphin.desktop"."_launch" = "none";
      "services/org.kde.konsole.desktop"."_launch" = "none";
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
      "kdeglobals"."General"."AccentColor" = "#b875dc";
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "none";
      "kdeglobals"."General"."accentColorFromWallpaper" = false;
      "kscreenlockerrc"."Daemon"."Autolock" = false;
      "kscreenlockerrc"."Daemon"."LockGrace" = 0;
      "kscreenlockerrc"."Daemon"."Timeout" = 0;
      "kscreenlockerrc"."Greeter/LnF/General"."showMediaControls" = false;
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "/home/panos/Pictures/wp12329537-nixos-wallpapers.png";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "/home/panos/Pictures/wp12329537-nixos-wallpapers.png";
      "kwinrc"."Effect-translucency"."ComboboxPopups" = 95;
      "kwinrc"."Effect-translucency"."Dialogs" = 96;
      "kwinrc"."Effect-translucency"."Menus" = 96;
      "kwinrc"."Effect-translucency"."MoveResize" = 89;
      "kwinrc"."Plugins"."kwin4_effect_geometry_changeEnabled" = true;
      "kwinrc"."Plugins"."translucencyEnabled" = true;
      "kwinrc"."Tiling"."padding" = 4;
      "kwinrc"."Windows"."ElectricBorders" = 1;
      "kwinrc"."org.kde.kdecoration2"."BorderSize" = "None";
      "kwinrc"."org.kde.kdecoration2"."BorderSizeAuto" = false;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "NFB";
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "IAX";
    };
  };
}