{ pkgs, config, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland 
    ];

    config.common.default = [ "hyprland" "gtk" ];
  };
  environment.systemPackages = with pkgs; [ xdg-desktop-portal xdg-utils];
}