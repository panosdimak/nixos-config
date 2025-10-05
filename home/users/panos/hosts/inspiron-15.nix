{ ... }:
{
  imports = [
    ../../../profiles/common.nix
    ../default.nix
  ];

  profiles.gtk.iconThemeName = "Colloid-Teal-Gruvbox-Light";

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080@60, 0x0, 1"
    ];

    env = [
      # Fix Electron apps rendering with fractional scaling
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      # Additional flags for Spotify/Electron apps
      "NIXOS_OZONE_WL,1"
    ];

    device = [
        { name = "ven_04f3:00-04f3:3259-touchpad"; sensitivity = -0.1; }
    ];

  };

  services.hypridle.settings = {
    listener = [
      {
        timeout = 120;  # Dim screen after 2 minutes
        "on-timeout" = "brightnessctl set 10%";
        "on-resume" = "brightnessctl set 100%";
      }
      {
        timeout = 240;  # Turn off screen after 4 minutes
        "on-timeout" = "hyprctl dispatch dpms off";
        "on-resume" = "hyprctl dispatch dpms on";
      }
      {
        timeout = 600;  # Suspend after 10 minutes
        "on-timeout" = "systemctl suspend";
      }
    ];
  };
}