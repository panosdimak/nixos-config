{ ... }:
{
  imports = [
    ../../../profiles/common.nix
    ../default.nix
  ];

  profiles.gtk.iconThemeName = "Colloid-Teal-Gruvbox-Light";

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080@60, 0x0, 1.2"
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
        timeout = 300;
        "on-timeout" = "hyprctl dispatch dpms off";
        "on-resume" = "hyprctl dispatch dpms on";
      }
      {
        timeout = 900;
        "on-timeout" = "systemctl suspend";
      }

    ];
  };
}