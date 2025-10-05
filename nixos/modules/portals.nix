{ pkgs, config, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config.common.default = [ "hyprland" "gtk" ];
  };
  environment.systemPackages = with pkgs; [ xdg-desktop-portal xdg-utils];
}