{ pkgs, ... }:

{
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us,gr";
    options = "grp:win_space_toggle";
    variant = "";
  };

  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.kdePackages.plasma-workspace ];
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };
}
