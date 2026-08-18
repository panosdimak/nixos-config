{...}: {
  imports = [
    ./common.nix
    ./default.nix
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-1";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1.2;
      }
    ];

    env = [
      {_args = ["ELECTRON_OZONE_PLATFORM_HINT" "auto"];}
    ];

    device = [
      {
        name = "ven_04f3:00-04f3:3259-touchpad";
        sensitivity = 0.1;
      }
    ];
  };
}
