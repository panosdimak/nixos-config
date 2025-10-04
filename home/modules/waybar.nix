{ ... }:

{
  programs.waybar.enable = true;

  programs.waybar.settings.main = {
    layer = "top";
    position = "top";
    height = 40;
    margin-top = 0;
    margin-left = 0;
    margin-right = 0;

    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
    ];
    modules-center = [
      "clock"
    ];
    modules-right = [
      # "idle_inhibitor"
      "tray"
      "pulseaudio"
      # "network",
      "memory"
      "cpu"
      "keyboard-state"
      "hyprland/language"
      "custom/rofi"
      "battery"
      "custom/notification"
      "custom/power"
    ];

    # --- Hyprland ---
    "hyprland/workspaces" = {
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      format = "{icon}";
      format-icons = {
        # "default": "{number}",
        #"active" = "";
        "urgent" = "";
      };
    };

    "hyprland/window" = {
      max-length = 30;
      separate-outputs = true;
      format = "{}";
    };

    "hyprland/language" = {
      format = "{short}";
      on-click = "hyprctl switchxkblayout logitech-usb-keyboard-system-control next";
    };

    # --- Core status ---
    "clock" = {
      "format" = "{:%a %d %b  %H:%M}";
      "tooltip-format" = "{:%Y-%m-%d}\nWeek %V";
    };

    "pulseaudio" = {
      # works fine with PipeWire (wpctl underneath)
      format = "{icon}  {volume:2}%";
      format-muted = "󰝟 muted";
      tooltip = true;
      scroll-step = 3;
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-click-right = "pavucontrol";
      format-icons = {
        "headphones" = "";
        "handsfree" = "";
        "headset" = "";
        "default" = ["" "" ""];
      };
    };

    "network" = {
      # nm-applet handles connections; this just shows status
      "interval" = 5;
      "format-ethernet" = "󰈀  {ifname}";
      "format-linked" = "󰈀 (no ip)";
      "format-disconnected" = "󰖪";
      "format-wifi" = "󰖩  {signalStrength}%";
      "tooltip-format" = "{ifname} via {gwaddr}\nIP: {ipaddr}";
    };

    "cpu" = {
      "interval" = 2;
      "format" = " {usage:2}%";
    };

    "memory" = {
      "interval" = 5;
      "format" = " {used:0.1f}G";
    };

    # --- Utilities ---
    "idle_inhibitor" = {
      # pairs nicely with hypridle/hyprlock
      "format" = "{icon}";
      "format-icons" = {
        "activated" = "";
        "deactivated" = "";
      };
      "timeout" = 0;
    };

    "tray" = {
      "icon-size" = 16;
      "spacing" = 8;
    };

    "battery" = {
      # base label
      "format" = "{icon} {capacity}%";
      # when actually charging
      "format-charging" = "{icon} {capacity}%";
      # when the adapter is plugged (AC online) but not charging
      "format-plugged" = " {capacity}%";        # Font Awesome "plug"
      # show the plug even when the battery is full
      "format-full" = " {capacity}%";
      # pick icons by status/capacity (optional)
      "format-icons" = {
        # discharging icons from empty → full
        "default" = ["" "" "" "" ""];
        # charging set (if you want a different look while charging)
        "charging" = ["" "" "" "" "" "" ""];
        # single icon when simply plugged
        "plugged" = "";
      };
    };

    # --- Custom buttons ---
    "custom/rofi" = {
      "format" = " apps";
      "tooltip" = false;
      "on-click" = "fuzzel";
    };

  "custom/notification" = {
      "tooltip" = false;
      "format" = "{icon}";
      "format-icons" = {
        "notification" = "󱅫";
        "none" = "󰂚";
        "dnd-notification" = "󰂛";
        "dnd-none" = "󰂛";
        "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "inhibited-none" = "";
        "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-inhibited-none" = "";
      };
      "return-type" = "json";
      "exec-if" = "which swaync-client";
      "exec" = "swaync-client -swb";
      "on-click" = "swaync-client -t -sw";
      "on-click-right" = "swaync-client -d -sw";
      "escape" = true;
    };

    "custom/power" = {
      "format" = "";
      "tooltip" = "Power menu";
      "on-click" = "~/nixos-config/scripts/power.sh";
    };
  };

  programs.waybar.style =
    ''
      * 
      {
        font-family: SFProDisplay Nerd Font, FiraCode Nerd Font, monospace;
        font-size: 12.5pt;
        /* font-weight: bold; */
        min-height: 0;
      }

      window#waybar {
        border: 2px solid #3C3836;
        border-radius: 14px;
        background: alpha(@theme_bg_color, 0.80);
      }

      #workspaces,
      #tray,
      #cpu, #memory,
      #pulseaudio,
      #network,
      #clock,
      #window,
      #idle_inhibitor,
      #custom-rofi,
      #custom-power,
      #custom-notification,
      #language {
        /* background: #3C3836; */
        padding: 8px 10px;
        /* margin: 0 6px; */
        /* border-radius: 12px; */
        /* box-shadow: 0 2px 10px rgba(0,0,0,0.35); */
        /* border: 2px solid transparent; */
      }

      #custom-notification {
        font-family: "NotoSansMono Nerd Font";
      }

      #workspaces button {
        padding: 0 8px;
        border-radius: 10px;
      }

      #workspaces button.active {
        /*color: #121212;*/
      }

      #workspaces button.urgent {
        background: #b3261e;
        color: #fff;
      }

      #pulseaudio.muted {
        /* color: #595959; */
      }
    '';
  
}
