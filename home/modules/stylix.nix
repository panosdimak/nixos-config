{ ... }:
{
  # Enable the apps so Stylix can write their settings
  programs = {
    vesktop.enable = true;
  };

  # Enable Home-Manager-only Stylix targets
  stylix.targets = {
    qt.enable = true;
    gtk.enable = true;
    btop.enable = true;
    nixos-icons.enable = true;
    swaync.enable = true;
    vesktop.enable = true;
    ghostty.enable = true;
  };
}