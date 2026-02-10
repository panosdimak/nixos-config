{ lib, ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = lib.mkForce "Monospace:size=16";
        dpi-aware = "no";
        use-bold = "yes";
        icon-theme = "Colloid-Dark";
        # Include matugen-generated colors
        include = "~/.config/fuzzel/colors.ini";
      };

      border = {
        width = 2;
        selection-radius = 4;
      };
    };
  };
}
