{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  services.gnome.gnome-keyring.enable = true;
  
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    rofi-wayland
    swaynotificationcenter
    networkmanagerapplet
    waybar
    hyprpaper
    hyprpolkitagent
    hypridle
    hyprlock
    hyprpicker
    hyprsysteminfo
    hyprsunset
    cliphist
    playerctl
    libsecret
  ];
  
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
