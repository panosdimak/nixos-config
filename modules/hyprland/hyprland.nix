{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  services.gnome.gnome-keyring.enable = true;
  
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.seahorse.enable = true;

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
