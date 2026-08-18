{pkgs, ...}: {
  imports = [
    ./common.nix
    ./default.nix
    ./modules/music-production.nix
  ];

  home.packages = with pkgs; [qpwgraph];

  wayland.windowManager.hyprland.settings = {
    autostart._var = ["qpwgraph"];

    monitor = [
      {
        output = "HDMI-A-1";
        mode = "1920x1080@72";
        position = "0x0";
        scale = 1;
      }
    ];

    env = [
      {_args = ["LIBVA_DRIVER_NAME" "nvidia"];}
      {_args = ["__GLX_VENDOR_LIBRARY_NAME" "nvidia"];}
      {_args = ["VK_DRIVER_FILES" "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json"];}
    ];

    device = [
      {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      }
    ];
  };
}
