{ ... }:
{
  imports = [
  # Common Home profile used by all hosts
  ../../../profiles/common.nix
  # User defaults
  ../default.nix
  # Host-specific extras
  ../../../modules/music-production.nix
  ../../../modules/spicetify.nix
  ];

  profiles.gtk.iconThemeName = "Colloid-Pink-Gruvbox-Light";

  wayland.windowManager.hyprland.settings = {
    monitor = [ "HDMI-A-1, 1920x1080@72, 0x0, 1" ];
    env = [
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ];
  };
}
