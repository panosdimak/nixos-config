{ pkgs, inputs, ...}:

{
  stylix = {
    enable = true;
    
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
    targets.plymouth.enable = true;

    fonts = {
      monospace = { 
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd;
        name = "SFMono Nerd Font";
      };
      sansSerif = { 
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };

      serif     = { package = pkgs.noto-fonts; name = "Noto Serif"; };
      emoji     = { package = pkgs.noto-fonts-emoji; name = "Noto Color Emoji"; };
    
      sizes = {
        applications = 10;  # GTK app/UI text (Firefox chrome)
        desktop      = 10;  # titles, bars
        popups       = 10;  # menus/notifications
        terminal     = 12;
      };
    };
  };
}
