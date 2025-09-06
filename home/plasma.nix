{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "ActivityManager"."switch-to-activity-19e4295d-1bca-466f-af0e-ca06f5fd7433" = "none,none,Switch to activity \"Default\"";

      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = ["Meta+Alt+L" "Meta+Alt+L,Switch to Last-Used Keyboard Layout"];
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = ["Meta+Alt+K" "Meta+Alt+K,Switch to Next Keyboard Layout"];

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

      "org_kde_powerdevil"."Decrease Keyboard Brightness" = ["Keyboard Brightness Down" "Keyboard Brightness Down,Decrease Keyboard Brightness"];
      "org_kde_powerdevil"."Decrease Screen Brightness" = ["Monitor Brightness Down" "Monitor Brightness Down,Decrease Screen Brightness"];
      "org_kde_powerdevil"."Decrease Screen Brightness Small" = ["Shift+Monitor Brightness Down" "Shift+Monitor Brightness Down,Decrease Screen Brightness by 1%"];
      "org_kde_powerdevil"."Hibernate" = ["Hibernate" "Hibernate,Hibernate"];
      "org_kde_powerdevil"."Increase Keyboard Brightness" = ["Keyboard Brightness Up" "Keyboard Brightness Up,Increase Keyboard Brightness"];
      "org_kde_powerdevil"."Increase Screen Brightness" = ["Monitor Brightness Up" "Monitor Brightness Up,Increase Screen Brightness"];
      "org_kde_powerdevil"."Increase Screen Brightness Small" = ["Shift+Monitor Brightness Up" "Shift+Monitor Brightness Up,Increase Screen Brightness by 1%"];
      "org_kde_powerdevil"."PowerDown" = ["Power Down" "Power Down,Power Down"];
      "org_kde_powerdevil"."PowerOff" = ["Power Off" "Power Off,Power Off"];
      "org_kde_powerdevil"."Sleep" = ["Sleep" "Sleep,Suspend"];
      "org_kde_powerdevil"."Toggle Keyboard Backlight" = ["Keyboard Light On/Off" "Keyboard Light On/Off,Toggle Keyboard Backlight"];
      "org_kde_powerdevil"."Turn Off Screen" = "none,none,Turn Off Screen";
      "org_kde_powerdevil"."powerProfile" = ["Battery" "Meta+B,Battery" "Meta+B,Switch Power Profile"];

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
      "services/org.kde.dolphin.desktop"."_launch" = "none";
      "services/org.kde.konsole.desktop"."_launch" = "none";
    };

     panels = [
      {
        location = "bottom";     # bottom | top | left | right
        height = 48;             # pixels

        widgets = [ 
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"        
        ];
        # other optional bits:
        # floating = true;
        # lengthMode = "fill";   # or "custom"
        # screen = 0;            # which monitor
        # widgets = [ ... ];
      }
    ];

    configFile = {
      "baloofilerc"."General"."dbVersion" = 2;
      "baloofilerc"."General"."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
      "baloofilerc"."General"."exclude filters version" = 9;
      "dolphinrc"."DetailsMode"."PreviewSize" = 16;
      "dolphinrc"."General"."ViewPropsTimestamp" = "2025,8,4,20,44,27.998";
      "dolphinrc"."IconsMode"."PreviewSize" = 80;
      "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      "kactivitymanagerdrc"."activities"."19e4295d-1bca-466f-af0e-ca06f5fd7433" = "Default";
      "kactivitymanagerdrc"."main"."currentActivity" = "19e4295d-1bca-466f-af0e-ca06f5fd7433";
      "katerc"."General"."Days Meta Infos" = 30;
      "katerc"."General"."Save Meta Infos" = true;
      "katerc"."General"."Show Full Path in Title" = false;
      "katerc"."General"."Show Menu Bar" = true;
      "katerc"."General"."Show Status Bar" = true;
      "katerc"."General"."Show Tab Bar" = true;
      "katerc"."General"."Show Url Nav Bar" = true;
      "katerc"."KTextEditor Renderer"."Animate Bracket Matching" = false;
      "katerc"."KTextEditor Renderer"."Auto Color Theme Selection" = true;
      "katerc"."KTextEditor Renderer"."Color Theme" = "Breeze Light";
      "katerc"."KTextEditor Renderer"."Line Height Multiplier" = 1;
      "katerc"."KTextEditor Renderer"."Show Indentation Lines" = false;
      "katerc"."KTextEditor Renderer"."Show Whole Bracket Expression" = false;
      "katerc"."KTextEditor Renderer"."Text Font" = "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "katerc"."KTextEditor Renderer"."Text Font Features" = "";
      "katerc"."KTextEditor Renderer"."Word Wrap Marker" = false;
      "katerc"."filetree"."editShade" = "183,220,246";
      "katerc"."filetree"."listMode" = false;
      "katerc"."filetree"."middleClickToClose" = false;
      "katerc"."filetree"."shadingEnabled" = true;
      "katerc"."filetree"."showCloseButton" = false;
      "katerc"."filetree"."showFullPathOnRoots" = false;
      "katerc"."filetree"."showToolbar" = true;
      "katerc"."filetree"."sortRole" = 0;
      "katerc"."filetree"."viewShade" = "211,190,222";
      "kcminputrc"."Keyboard"."NumLock" = 0;
      "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      "kded5rc"."Module-device_automounter"."autoload" = false;
      "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "960,540";
      "kdeglobals"."DirSelect Dialog"."Splitter State" = "\x00\x00\x00\xff\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x8d\x00\x00\x02\xa8\x00\xff\xff\xff\xff\x01\x00\x00\x00\x01\x00";
      "kdeglobals"."General"."AccentColor" = "165,118,236";
      "kdeglobals"."General"."LastUsedCustomAccentColor" = "233,58,154";
      "kdeglobals"."General"."TerminalApplication" = "ghostty";
      "kdeglobals"."General"."TerminalService" = "com.mitchellh.ghostty.desktop";
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "none";
      "kdeglobals"."General"."accentColorFromWallpaper" = true;
      "kdeglobals"."General"."fixed" = "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."font" = "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."menuFont" = "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."smallestReadableFont" = "Inter,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."toolBarFont" = "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."Icons"."Theme" = "Fluent-light";
      "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
      "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
      "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 142;
      "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      "kdeglobals"."WM"."activeBackground" = "227,229,231";
      "kdeglobals"."WM"."activeBlend" = "227,229,231";
      "kdeglobals"."WM"."activeFont" = "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."WM"."activeForeground" = "35,38,41";
      "kdeglobals"."WM"."inactiveBackground" = "239,240,241";
      "kdeglobals"."WM"."inactiveBlend" = "239,240,241";
      "kdeglobals"."WM"."inactiveForeground" = "112,125,138";
      "kiorc"."Confirmations"."ConfirmDelete" = true;
      "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
      "klipperrc"."General"."IgnoreImages" = false;
      "kscreenlockerrc"."Daemon"."Autolock" = false;
      "kscreenlockerrc"."Daemon"."LockGrace" = 0;
      "kscreenlockerrc"."Daemon"."Timeout" = 0;
      "kscreenlockerrc"."Greeter/LnF/General"."showMediaControls" = false;
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "/home/panos/Pictures/wp12329537-nixos-wallpapers.png";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "/home/panos/Pictures/wp12329537-nixos-wallpapers.png";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."SlidePaths" = "/home/potis/.local/share/wallpapers/,/nix/store/ar86gwyrbv73lg3j14zsmqm03s1dz3c3-breeze-6.3.6/share/wallpapers/,/run/current-system/sw/share/wallpapers/";
      "ksmserverrc"."General"."confirmLogout" = false;
      "ksmserverrc"."General"."loginMode" = "emptySession";
      "ksplashrc"."KSplash"."Engine" = "none";
      "ksplashrc"."KSplash"."Theme" = "None";
      "kwalletrc"."Wallet"."First Use" = false;
      "kwinrc"."Activities/LastVirtualDesktop"."19e4295d-1bca-466f-af0e-ca06f5fd7433" = "731885d5-0bcd-4e8a-bc09-123292ca0a67";
      "kwinrc"."Desktops"."Id_1" = "731885d5-0bcd-4e8a-bc09-123292ca0a67";
      "kwinrc"."Desktops"."Id_2" = "01f38055-badd-47e2-bc98-697576c03a15";
      "kwinrc"."Desktops"."Number" = 2;
      "kwinrc"."Desktops"."Rows" = 1;
      "kwinrc"."Effect-blur"."BlurStrength" = 10;
      "kwinrc"."Effect-blur"."NoiseStrength" = 4;
      "kwinrc"."Effect-overview"."BorderActivate" = 9;
      "kwinrc"."Effect-translucency"."ComboboxPopups" = 95;
      "kwinrc"."Effect-translucency"."Dialogs" = 96;
      "kwinrc"."Effect-translucency"."Menus" = 96;
      "kwinrc"."Effect-translucency"."MoveResize" = 89;
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."LatitudeFixed" = 37.402492843511446;
      "kwinrc"."NightColor"."LongitudeFixed" = 22.55550986842104;
      "kwinrc"."NightColor"."Mode" = "Location";
      "kwinrc"."NightColor"."NightTemperature" = 3400;
      "kwinrc"."Plugins"."contrastEnabled" = false;
      "kwinrc"."Plugins"."kwin4_effect_geometry_changeEnabled" = true;
      "kwinrc"."Plugins"."translucencyEnabled" = true;
      "kwinrc"."Tiling"."padding" = 4;
      "kwinrc"."Tiling/01f38055-badd-47e2-bc98-697576c03a15/6a83778b-4436-4add-a506-898011d72517"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/01f38055-badd-47e2-bc98-697576c03a15/bddec4b6-f154-4f03-9440-d7829ceadd1c"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/731885d5-0bcd-4e8a-bc09-123292ca0a67/540cdb22-f3b9-402d-bcfc-103a1f5e20f0"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/731885d5-0bcd-4e8a-bc09-123292ca0a67/6a83778b-4436-4add-a506-898011d72517"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/731885d5-0bcd-4e8a-bc09-123292ca0a67/bddec4b6-f154-4f03-9440-d7829ceadd1c"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/731885d5-0bcd-4e8a-bc09-123292ca0a67/d9803b3b-7974-4274-9e01-fec24e042adc"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/7e1ebf38-f21e-4cc1-9eb5-286b98cf0a1a/d9803b3b-7974-4274-9e01-fec24e042adc"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/d02c035d-eef0-5c68-aa2f-2e83d0ba08b1"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/e4db7b8a-7484-57e7-8bf3-5b450f4020f7"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Windows"."ElectricBorders" = 1;
      "kwinrc"."Xwayland"."Scale" = 1;
      "kwinrc"."org.kde.kdecoration2"."BorderSize" = "None";
      "kwinrc"."org.kde.kdecoration2"."BorderSizeAuto" = false;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "NFB";
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "IAX";
      "kwinrc"."org.kde.kdecoration2"."theme" = "__aurorae__svg__Utterly-Round-Dark";
      "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      "plasmanotifyrc"."Applications/discord"."Seen" = true;
      "plasmanotifyrc"."Applications/org.qbittorrent.qBittorrent"."Seen" = true;
      "plasmanotifyrc"."Applications/org.telegram.desktop"."Seen" = true;
      "plasmanotifyrc"."Applications/vesktop"."Seen" = true;
      "plasmarc"."Theme"."name" = "Utterly-Round";
      "plasmarc"."Wallpapers"."usersWallpapers" = "/home/panos/Pictures/wp12329537-nixos-wallpapers.png";
      "spectaclerc"."ImageSave"."lastImageSaveLocation" = "file:///tmp/tmp.IbA1ePwMsX.png";
      "spectaclerc"."ImageSave"."translatedScreenshotsFolder" = "Screenshots";
      "spectaclerc"."VideoSave"."translatedScreencastsFolder" = "Screencasts";
    };
  };
}