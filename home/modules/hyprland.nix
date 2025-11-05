{ ... }:
{
  # Hyprland (user-scoped config via Home Manager)
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    systemd.enable = true;

  settings = {
      # Variables / apps
      "$terminal" = "ghostty";
      "$fileManager" = "thunar";
      "$browser" = "zen-twilight";
      "$menu" = "fuzzel";

      # Autostart
      exec-once = [
        "waypaper --restore"
        "nm-applet"
        "blueman-applet"
        "swaync"
        "hypridle"
        "hyprpaper"
        "waybar"
        "sunsetr"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "ghostty --quit-after-last-window-closed=false --initial-window=false"
        "thunar --daemon"
        "vesktop --start-minimized"
      ];

      # Environment
  env = [
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
        # Keep as-is from your config; harmless if redundant
        "NIX_PROFILES,/etc/profiles/per-user/panos /run/current-system/sw /nix/var/nix/profiles/default /home/panos/.local/state/nix/profile /nix/profile /home/panos/.nix-profile"
      ];

      # Look and Feel
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # "col.active_border" = "rgba(e2bc7bee) rgba(117cb0ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = { new_status = "master"; };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        middle_click_paste = false;
        focus_on_activate = true;
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
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        "$mainMod, F, fullscreen,"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod, A, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, G, exec, hyprpicker -a"

        # Focus movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

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

        "$mainMod, Tab, workspace, previous"

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
        "$mainMod, ESCAPE, exec, ~/nixos-config/scripts/power.sh"
        "$mainMod SHIFT, S, exec, ~/nixos-config/scripts/snipping-tool.sh"
        "$mainMod SHIFT, T, exec, ~/nixos-config/scripts/ocr-hyprland.sh"
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
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # Gestures
      gesture = [
        "3, horizontal, workspace"
        "3, up, fullscreen"
        "4, down, close"
        "2, pinch, mod: SUPER, resize"
        "3, right, mod: SUPER, dispatcher, movetoworkspace, r-1"
        "3, left, mod: SUPER, dispatcher, movetoworkspace, r+1"
      ];
    };

    extraConfig = ''
      # Layer rules / blur for waybar
      blurls = waybar
      layerrule = blur,waybar
    '';
  };
}
