{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  # Exclude some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo-widgets
    kate
    konsole
    krdp
    xwaylandvideobridge
  ];
}