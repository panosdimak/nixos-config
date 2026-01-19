{ pkgs, inputs, ... }:
{
  # Hyprland (user-scoped config via Home Manager)
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    systemd.enable = true;

    # Hyprland plugins (from hyprland-plugins flake)
    # NOTE: hyprexpo temporarily disabled - incompatible with Hyprland 0.52.0 API
    # See: https://github.com/hyprwm/hyprland-plugins for updates
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      # hyprbars       # Window title bars
      # hyprexpo       # Workspace overview (like GNOME overview) - API mismatch
      # hyprtrails     # Trail effect behind moving windows
      # hyprwinwrap    # Wallpaper windows
      # borders-plus-plus  # Extra border styling
    # ];
    plugins = [
      inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
    ];

  settings = {
      # Variables / apps
      "$terminal" = "kitty";
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
        "sww-daemon"
        "waybar"
        "sunsetr"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "thunar --daemon"
        "vesktop --start-minimized"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
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
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
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
          range = 10;
          render_power = 10;
        };
        blur = {
          enabled = true;
          size = 12;
          passes = 2;
          noise = 0.1;
          contrast = 2;
          vibrancy = 0.5;
          brightness = 0.8;
          new_optimizations = true;
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
          "windowsOut, 1, 3, modern, popin"
          "windowsMove, 1, 4, modern, slide"

          "layersIn, 1, 2, inoutqubic, popin"

          "fadeIn, 1, 5, modern"
          "fadeOut, 1, 5, modern"
          "fadeSwitch, 1, 5, modern"
          "fadeShadow, 1, 5, modern"
          "fadeDim, 1, 5, modern"
          "fadeLayers, 1, 4, inoutqubic"
          "fadePopups, 1, 3, default"

          "border, 1, 3, modern"

          "workspaces, 1, 5, modern, slide"
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
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        "$mainMod, F, fullscreen,"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod, A, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, S, exec, hyprshot -m window --clipboard-only"
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

        "ALT, Tab, workspace, previous"
        "$mainMod, Tab, hyprtasking:toggle, all"

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
        "suppress_event maximize, match:class .*"
        "no_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"
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
      layerrule = blur on, match:class waybar
      layerrule = blur on, match:class launcher
      layerrule = ignore_alpha 0.5, match:class waybar
      layerrule = ignore_alpha 0.5, match:class launcher
    '';
  };
}
