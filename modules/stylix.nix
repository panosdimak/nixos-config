{ pkgs, ...}:

{
  stylix = {
    enable = true;
  
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    fonts = {
      monospace = { 
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = { 
        package = pkgs.inter;
        name = "Inter";
      };

      serif     = { package = pkgs.noto-fonts; name = "Noto Serif"; };
      emoji     = { package = pkgs.noto-fonts-emoji; name = "Noto Color Emoji"; };
    
      sizes = {
        applications = 10;  # GTK app/UI text (Firefox chrome)
        desktop      = 10;  # titles, bars
        popups       = 10;  # menus/notifications
        terminal     = 11;
      };

    };
    targets.qt.enable = false;
  };
}
