{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./default.nix
    ./modules/music-production.nix
  ];

  home.packages = with pkgs; [ qpwgraph ];

  wayland.windowManager.hyprland.settings = {
    exec-once = ["qpwgraph"];
    monitor = [ "HDMI-A-1, 1920x1080@72, 0x0, 1" ];
    env = [
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "VK_DRIVER_FILES,/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json"
    ];

    device = [
      { name = "epic-mouse-v1"; sensitivity = -0.5; }
    ];

  };
}