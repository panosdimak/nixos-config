{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;  # makes xdg-open go through portals too
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland  # Hyprland-native portal
      xdg-desktop-portal-gtk       # GTK fallback (file picker, screenshots, etc.)
    ];

    # Prefer Hyprland+GTK when XDG_CURRENT_DESKTOP=Hyprland
    config = {
      common.default = [ "hyprland" "gtk" ];
    };
  };

}