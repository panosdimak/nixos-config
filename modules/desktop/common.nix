{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;  # makes xdg-open go through portals too
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland  # Hyprland-native portal
      xdg-desktop-portal-gtk       # GTK fallback (file picker, screenshots, etc.)
      kdePackages.xdg-desktop-portal-kde  # keep this for Plasma sessions
    ];

    # Prefer Hyprland+GTK when XDG_CURRENT_DESKTOP=Hyprland, keep KDE for Plasma
    config = {
      common.default = [ "hyprland" "gtk" ];
      kde.default    = [ "kde" ];
    };
  };

}