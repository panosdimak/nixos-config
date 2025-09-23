{ lib, config, ... }:

let
  cfg = config.profiles.gtk;
in {
  options.profiles.gtk = {
    iconThemeName = lib.mkOption {
      type = lib.types.str;
      default = "Colloid-Pink-Gruvbox-Light";
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
    };
  };
}