{
  config,
  pkgs,
  inputs,
  ...
}: let
  snipping-tool = pkgs.writeShellApplication {
    name = "snipping-tool";
    runtimeInputs = with pkgs; [grim slurp wl-clipboard libnotify swappy coreutils];
    text = ''
      DIR="$HOME/Pictures/Screenshots"
      mkdir -p "$DIR"

      TMP="$(mktemp --suffix=.png)"

      if ! grim -g "$(slurp)" "$TMP"; then
        rm -f "$TMP"
        exit 0
      fi

      wl-copy < "$TMP"

      choice="$(
        notify-send \
          -a "Screenshot" \
          -i "$TMP" \
          -u low \
          -t 6000 \
          -A "edit=Edit in Swappy" \
          -A "save=Save to file" \
          -A "discard=Discard" \
          "Screenshot taken" "Choose what to do (or ignore)" \
          --wait
      )"

      case "$choice" in
        edit|1)
          swappy -f "$TMP"
          rm -f "$TMP"
          ;;
        save|2)
          FILE="$DIR/Screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
          mv "$TMP" "$FILE"
          notify-send -a "Screenshot" -i "$FILE" "Saved" "$FILE"
          ;;
        discard|3|"")
          rm -f "$TMP"
          ;;
      esac
    '';
  };

  ocr-screenshot = pkgs.writeShellApplication {
    name = "ocr-screenshot";
    runtimeInputs = with pkgs; [grim slurp tesseract wl-clipboard];
    text = ''
      IMG=$(mktemp --suffix=.png)
      grim -g "$(slurp)" "$IMG"
      tesseract "$IMG" - -l eng+ell | wl-copy
      rm -f "$IMG"
    '';
  };
in {
  # Symlink the quickshell-overview module files into ~/.config/quickshell/overview.
  # recursive = true so the directory is real and the user can drop in a config.json
  # alongside the read-only symlinks if they want to override defaults.
  xdg.configFile."quickshell/overview" = {
    source = inputs.quickshell-overview;
    recursive = true;
  };

  # Hyprland (user-scoped config via Home Manager)
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    systemd.enable = true;

    plugins = [
      # inputs.hyprtasking.packages.${pkgs.stdenv.hostPlatform.system}.hyprtasking
    ];

    settings = {
      # Variables / apps
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$browser" = "zen-twilight";
      "$menu" = "fuzzel";

      # Autostart
      exec-once = [
        "waypaper --restore"
        "nm-applet"
        "blueman-applet"
        "hypridle"
        "vicinae server"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "vesktop --start-minimized"
        "qs -c overview"
        # "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];

      # Environment
      env = [
        "TERMINAL,kitty"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GTK_USE_PORTAL,1"
        "QT_QPA_PLATFORM,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
        "NIX_PROFILES,/etc/profiles/per-user/${config.home.username} /run/current-system/sw /nix/var/nix/profiles/default ${config.home.homeDirectory}/.local/state/nix/profile /nix/profile ${config.home.homeDirectory}/.nix-profile"
      ];

      # Look and Feel
      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 0;
        float_gaps = -1; # use same gaps for floating windows as tiled (-1 = inherit)
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        # Snap floating windows to each other and monitor edges
        snap = {
          enabled = true;
          window_gap = 10; # min gap before snapping to other windows (px)
          monitor_gap = 10; # min gap before snapping to monitor edges (px)
        };
      };

      decoration = {
        rounding = 12;
        rounding_power = 4;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 10;
          render_power = 2;
        };
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          noise = 0;
          contrast = 2;
          vibrancy = 0.5;
          brightness = 0.8;
          # Blur right-click menus/popups against the app beneath them.
          # ignorealpha skips the menu's transparent drop-shadow margin so the
          # blur doesn't bleed into a halo border (popover bg alpha is 0.85).
          popups = true;
          popups_ignorealpha = 0.6;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "default, 0.42, 0, 0.58, 1"
          "fastmid, 0.785, 0.135, 0.15, 0.86"
          "inoutquart, 0.77, 0, 0.175, 1"
          "inoutqubic, 0.6, 0.13, 0.355, 1"
          "modern, 0.55, 0.12, 0, 0.93"
        ];

        animation = [
          "windows, 1, 3, modern, popin"
          "windowsIn, 1, 3, modern, popin"
          "windowsOut, 1, 2, modern, popin"
          "windowsMove, 1, 4, modern, slide"

          "layersIn, 1, 1, inoutqubic, popin"

          "fadeIn, 1, 5, modern"
          "fadeOut, 1, 3, modern"
          "fadeSwitch, 1, 5, modern"
          "fadeShadow, 1, 5, modern"
          "fadeDim, 1, 5, modern"
          "fadeLayers, 1, 3, inoutqubic"
          "fadePopups, 1, 3, default"

          "border, 1, 3, modern"

          "workspaces, 1, 4, modern, slidefade"
          # Animate the special workspace toggle (SUPER+Z)
          "specialWorkspace, 1, 4, modern, slidefadevert"
          # Fade effect when monitors turn on/off via DPMS
          "fadeDpms, 1, 5, modern"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      master = {new_status = "master";};

      misc = {
        force_default_wallpaper = 0; # plain background, no anime
        disable_hyprland_logo = true;
        disable_splash_rendering = true; # no version/quote splash text during the gap before DMS draws
        middle_click_paste = false;
        focus_on_activate = true;
        vrr = 1; # enable variable refresh rate (FreeSync/G-Sync) on supported monitors
      };

      # Bind behavior tweaks
      binds = {
        workspace_center_on = 1; # center cursor on focused window (not workspace center) on switch
      };

      # Cursor behavior
      cursor = {
        persistent_warps = true; # restore cursor position when refocusing a window
        hide_on_key_press = true; # auto-hide cursor while typing
        warp_on_change_workspace = 1; # warp cursor to last focused window on workspace switch
        inactive_timeout = 5; # hide cursor after 5 seconds of inactivity
      };

      # Rendering performance
      render = {
        direct_scanout = 1; # allow direct scanout for fullscreen apps (better perf, 0=off/1=try/2=force)
      };

      # Input
      input = {
        kb_layout = "us,gr";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.25;
        };
      };

      # Keybindings
      "$mainMod" = "SUPER";

      bind = [
        "SUPER, F12, exec, sh -lc 'env > /tmp/hypr-bind-env.txt'"
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        "$mainMod, F, fullscreen,"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod, A, exec, vicinae vicinae://toggle"
        "$mainMod, P, pseudo,"
        "$mainMod, D, layoutmsg, togglesplit"
        "$mainMod, S, exec, hyprshot -m window --clipboard-only"
        "$mainMod, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
        "$mainMod, L, exec, dms ipc lock lock"
        "$mainMod, G, exec, hyprpicker -a"

        "$mainMod, C, centerwindow," # center focused floating window on monitor
        "$mainMod, R, submap, resize" # enter resize mode (arrow keys to resize, Escape to exit)

        # Focus movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Swap windows
        "$mainMod SHIFT, left, swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up, swapwindow, u"
        "$mainMod SHIFT, down, swapwindow, d"

        # Workspaces 1-10
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "ALT, Tab, workspace, previous"

        # Overview (standalone quickshell-overview; DMS's hyprland overview is broken)
        "$mainMod, Tab, exec, qs ipc -c overview call overview toggle"

        # Next / prev workspace
        "SUPER, bracketright, workspace, r+1"
        "SUPER, bracketleft, workspace, r-1"
        "SUPER SHIFT, bracketright, movetoworkspace, r+1"
        "SUPER SHIFT, bracketleft, movetoworkspace, r-1"

        # New empty workspace & follow
        "SUPER SHIFT, N, movetoworkspace, empty"

        # Move focused window to workspace 1-10
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, Z, togglespecialworkspace, magic"
        "$mainMod SHIFT, Z, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Power menu & tools
        "$mainMod, ESCAPE, exec, dms ipc call powermenu toggle"
        "$mainMod SHIFT, S, exec, ${snipping-tool}/bin/snipping-tool"
        "$mainMod SHIFT, T, exec, ${ocr-screenshot}/bin/ocr-screenshot"
        ", PRINT, exec, grim ~/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png && notify-send \"Saved screenshot\""
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Media & brightness (hold-to-repeat/non-repeat)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Windows & rules
      windowrule = [
        "suppress_event maximize, match:class .*"
        "no_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"
        # Center floating XWayland dialogs (e.g. REAPER/OnlyOffice confirm
        # dialogs that otherwise spawn in the top-left corner).
        # match:modal excludes dropdown/popup menus (which are never modal).
        "center 1, match:class .*, match:xwayland true, match:float true, match:modal true"

        # Prevent idle/lock while watching media (always for mpv, only fullscreen for browsers)
        "idle_inhibit always, match:class mpv"
        "idle_inhibit fullscreen, match:class firefox"
        "idle_inhibit fullscreen, match:class zen"

        # Auto-float, pin, and position picture-in-picture windows (bottom-right corner)
        "float on, match:title (Picture-in-Picture)"
        "pin on, match:title (Picture-in-Picture)"
        "size 480 270, match:title (Picture-in-Picture)"
        "move 100%-490 100%-280, match:title (Picture-in-Picture)"

        # Preserve aspect ratio when resizing media windows
        "keep_aspect_ratio on, match:class mpv"

        # Mark game windows for VRR/tearing support
        "content game, match:class steam_app_.*"
        "immediate on, match:class steam_app_.*"
      ];

      # Gestures
      gesture = [
        "3, horizontal, workspace"
        "3, up, dispatcher, hyprtasking:toggle, all"
        "4, down, close"
        "2, pinch, mod: SUPER, resize"
        "3, right, mod: SUPER, dispatcher, movetoworkspace, r-1"
        "3, left, mod: SUPER, dispatcher, movetoworkspace, r+1"
      ];

      # Workspace rules
      workspace = [
        "special:magic, gapsout:30" # larger outer gaps on the special workspace
      ];

      # Hyprtasking plugin
      plugin = {
        hyprtasking = {
          layout = "grid";

          gap_size = 15;
          # bg_color is set in extraConfig after sourcing colors.conf
          border_size = 4;
          exit_on_hovered = false;
          warp_on_move_window = 1;
          close_overview_on_reload = true;

          drag_button = "0x111";
          select_button = "0x110";

          gestures = {
            enabled = false;
            move_fingers = 3;
            move_distance = 300;
            open_fingers = 4;
            open_distance = 300;
            open_positive = true;
          };

          grid = {
            rows = 3;
            cols = 3;
            loop = false;
            gaps_use_aspect_ratio = false;
          };

          linear = {
            height = 400;
            scroll_speed = 1.0;
            blur = false;
          };
        };
      };
    };

    extraConfig = ''
      # Source matugen-generated colors
      source = ~/.config/hypr/colors.conf

      # Apply colors from variables (must be after source)
      general:col.active_border = $active_border
      general:col.inactive_border = $inactive_border
      plugin:hyprtasking:bg_color = $hyprtaskingBg

      # Vesktop (Electron/Wayland) declares its surface opaque once focused/fully
      # rendered, so Hyprland honours that and stops blurring behind it (blur only
      # shows while unfocused or mid-load). Forcing opacity just below 1 makes
      # Hyprland blend the window and re-apply blur regardless of the opaque-region
      # hint; override on both active/inactive keeps it stable across focus.
      # blur:ignore_opacity (default on) keeps the blur at full strength.
      windowrule = opacity 0.99 override 0.99 override, match:class vesktop

      # Layer rules / blur for waybar
      layerrule = blur on, match:class waybar
      layerrule = blur on, match:class launcher
      layerrule = ignore_alpha 0.5, match:class waybar
      layerrule = ignore_alpha 0.5, match:class launcher

      layerrule {
        name = vicinae-blur
        blur = on
        ignore_alpha = 0
        match:namespace = vicinae
      }

      # Resize submap: enter with SUPER+R, use arrow keys to resize, Escape to exit
      submap = resize
      binde = , right, resizeactive, 30 0
      binde = , left, resizeactive, -30 0
      binde = , up, resizeactive, 0 -30
      binde = , down, resizeactive, 0 30
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
