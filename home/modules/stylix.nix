{ pkgs, ... }:

# Stylix Home Manager targets
#
# Role division:
# - Stylix: Fonts only (configured in nixos/modules/stylix.nix)
# - Matugen: All colors (dynamic, wallpaper-based)
#
# autoEnable = false disables all targets, then we allow-list
# only font-related ones so no Stylix colors leak through.

{
  stylix.autoEnable = false;

  stylix.targets = {
    fontconfig.enable = true;
    font-packages.enable = true;
    nixos-icons.enable = true;
  };
}
