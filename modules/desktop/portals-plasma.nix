{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;  # makes xdg-open go through portals too
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];

    config = {
      kde.default    = [ "kde" ];
    };
  };

}