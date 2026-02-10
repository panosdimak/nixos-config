{ pkgs, ... }:

# Stylix Home Manager targets
#
# Role division:
# - Stylix: Fonts only (configured in nixos/modules/stylix.nix)
# - Matugen: All colors (dynamic, wallpaper-based)
#
# We disable all color-related Stylix targets since matugen
# generates colors at runtime when the wallpaper changes.

{
  stylix.targets = {
    # Disabled - matugen handles these dynamically
    gtk.enable = false;
    swaync.enable = false;
    fuzzel.enable = false;
    waybar.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
    qt.enable = false;
    kde.enable = false;
    vesktop.enable = false;
    btop.enable = false;
    starship.enable = false;

    # Enabled
    nixos-icons.enable = true;
    neovim.transparentBackground = {
      main = true;
      signColumn = true;
    };
  };
}
