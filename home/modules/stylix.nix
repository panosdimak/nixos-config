{ lib, ... }:
{
  # Enable the apps so Stylix can write their settings
  programs = {
    # Required so Stylix can inject its theme into fuzzel's config
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.mkForce "SFMono Nerd Font:size=14.5";
          dpi-aware = "yes";
        };
        border = {
          selection-radius = 10;
        };
      };
    };
    vesktop.enable = true;
  };

  # Enable Home-Manager-only Stylix targets
  stylix.targets = {
    qt.enable = true;
    gtk.enable = true;
    btop.enable = true;
    nixos-icons.enable = true;
    swaync.enable = true;
    fuzzel.enable = true;
    vesktop.enable = true;
    ghostty.enable = true;
  };
}