{ config, lib, ... }:

let
  alpha = "99"; # choose your transparency (00–FF)
  bg = config.lib.stylix.colors.base00;     # RGB from Stylix theme
in
{
  programs.fuzzel = {
    enable = true;

    settings = {
      colors = {
        background = lib.mkForce "${bg}${alpha}";
      };

      main = {
        font = lib.mkForce "SFMono Nerd Font:size=16";
        dpi-aware = "no";
        use-bold = "yes";
        icon-theme = "Colloid-Dark";
      };

      border = {
        width = 2;
        selection-radius = 4;
      };
    };
  };
}
