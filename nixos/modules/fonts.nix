{
  pkgs,
  inputs,
  ...
}: {
  fonts.packages = [
    pkgs.geist-font
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
    pkgs.inter
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = ["GeistMono Nerd Font"];
      sansSerif = ["Geist" "Inter" "Noto Sans CJK JP" "Noto Color Emoji"];
      serif = ["Noto Serif"];
      emoji = ["Noto Color Emoji"];
    };

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
