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
      sansSerif = { package = pkgs.inter; name = "Inter"; };
      serif     = { package = pkgs.noto-fonts; name = "Noto Serif"; };
      emoji     = { package = pkgs.noto-fonts-emoji; name = "Noto Color Emoji"; };
    };
    targets.qt.enable = false;
  };
}
