{ lib, config, pkgs, ... }:

let
  cfg = config.profiles.gtk;
in {
  options.profiles.gtk = {
    iconThemeName = lib.mkOption {
      type = lib.types.str;
      default = "Fluent-dark";
      description = "GTK icon theme name to use.";
    };
    cursor = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Bibata-Modern-Classic";
        description = "Cursor theme name.";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 24;
        description = "Cursor size.";
      };
    };
  };

  config = {
    gtk = {
      enable = true;
      iconTheme.name = cfg.iconThemeName;
      cursorTheme = {
        name = cfg.cursor.name;
        size = cfg.cursor.size;
      };

      # Use adw-gtk3 which respects libadwaita color definitions
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      # Import matugen-generated colors in GTK3
      gtk3.extraCss = ''
        @import url("file://${config.xdg.configHome}/gtk-3.0/colors.css");
      '';

      # Import matugen-generated colors in GTK4
      gtk4.extraCss = ''
        @import url("file://${config.xdg.configHome}/gtk-4.0/colors.css");
      '';
    };
  };
}