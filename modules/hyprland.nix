{ inputs, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    rofi-wayland
    swaynotificationcenter
    networkmanagerapplet
    blueman
    waybar
    hyprpaper
    hyprpolkitagent
    hypridle
    hyprlock
    hyprpicker
    hyprsysteminfo
    hyprsunset
    inputs.sunsetr.packages.${pkgs.system}.sunsetr
    cliphist
    playerctl
    libsecret
    bibata-cursors
  ];
  
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
