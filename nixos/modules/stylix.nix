{ pkgs, inputs, ... }:

# Stylix system configuration
#
# Role division:
# - Stylix: Fonts and font rendering
# - Matugen: All colors (dynamic, wallpaper-based via home/modules/matugen.nix)

{
  stylix = {
    enable = true;
    autoEnable = false;           # disable all color theming

    targets.fontconfig.enable = true;      # set fonts in fontconfig defaults
    targets.font-packages.enable = true;   # install the font packages

    fonts = {
      monospace = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono-nerd;
        name = "SFMono Nerd Font";
      };
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
        name = "SFRounded Nerd Font";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 12;
      };
    };
  };

  fonts.fontconfig = {
    defaultFonts.sansSerif = [
      "SF Pro Display"
      "Noto Sans CJK JP"
      "Noto Color Emoji"
    ];

    hinting = {
      enable = true;
      style = "slight";
      autohint = false;
    };

    subpixel = {
      rgba = "rgb";
      lcdfilter = "light";
    };

    antialias = true;
  };
}
