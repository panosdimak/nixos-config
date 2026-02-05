{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  
  environment.systemPackages = with pkgs; [
    fuzzel
    vicinae
    swaynotificationcenter
    libnotify
    swappy
    networkmanagerapplet
    blueman
    waybar
    swww
    hypridle
    hyprlock
    hyprpicker
    hyprsysteminfo
    hyprshot
    brightnessctl
    sunsetr
    cliphist
    playerctl
    libsecret
    bibata-cursors
    colloid-icon-theme
    kdePackages.breeze-icons
  ];
 
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";
}
