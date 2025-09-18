{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    tofi
    rofi-wayland
    mako
    networkmanagerapplet
    waybar
    hyprpaper
    hyprpolkitagent
    hypridle
    hyprpicker
    cliphist
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
