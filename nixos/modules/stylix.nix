{ pkgs, inputs, ...}:

{
  stylix = {
    enable = true;
   
    base16Scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";
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

# Make sure the fallback fonts are actually installed
  fonts.packages = with pkgs; [
    noto-fonts                  # Latin etc.
    noto-fonts-cjk-sans         # JP/CJK coverage (Noto Sans CJK JP)
    noto-fonts-emoji            # Color emoji
  ];

  # Define fallback order (what fontconfig prefers when glyphs are missing)
  fonts.fontconfig.defaultFonts = {
    sansSerif = [
      "SF Pro Display"          # your main UI font
      "Noto Sans CJK JP"        # JP fallback (covers ［］／弦… etc.)
      "Noto Color Emoji"        # emoji fallback
    ];
  };
}
