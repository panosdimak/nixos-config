{ inputs, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    fuzzel
    swaynotificationcenter
    libnotify
    swappy
    networkmanagerapplet
    blueman
    waybar
    hyprpaper
    hypridle
    hyprlock
    hyprpicker
    hyprsysteminfo
    brightnessctl
    inputs.sunsetr.packages.${pkgs.system}.sunsetr
    cliphist
    playerctl
    libsecret
    bibata-cursors
  ];
 
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  
  services.power-profiles-daemon.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";
}
