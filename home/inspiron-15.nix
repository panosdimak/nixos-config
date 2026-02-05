{ ... }:
{
  imports = [
    ./common.nix
    ./default.nix
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080@60, 0x0, 1.2"
    ];

    env = [
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
    ];

    device = [
        { name = "ven_04f3:00-04f3:3259-touchpad"; sensitivity = -0.1; }
    ];

  };
}
