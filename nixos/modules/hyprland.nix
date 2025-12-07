{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  
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
    hyprshot
    brightnessctl
    inputs.sunsetr.packages.${pkgs.system}.sunsetr
    cliphist
    playerctl
    libsecret
    bibata-cursors
    colloid-icon-theme
  ];
 
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";
}
