{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/waybar-colors.css".text = ''
      @define-color background #{{colors.surface.default.hex_stripped}};
      @define-color foreground #{{colors.on_surface.default.hex_stripped}};
      @define-color primary #{{colors.primary.default.hex_stripped}};
      @define-color on_primary #{{colors.on_primary.default.hex_stripped}};
      @define-color secondary #{{colors.secondary.default.hex_stripped}};
      @define-color on_secondary #{{colors.on_secondary.default.hex_stripped}};
      @define-color surface #{{colors.surface.default.hex_stripped}};
      @define-color surface_container #{{colors.surface_container.default.hex_stripped}};
      @define-color surface_bright #{{colors.surface_bright.default.hex_stripped}};
      @define-color error #{{colors.error.default.hex_stripped}};
    '';
  };

  fallback = createIfMissing "${configHome}/waybar/colors.css" ''
@define-color background #${colors.surface};
@define-color foreground #${colors.on_surface};
@define-color primary #${colors.primary};
@define-color on_primary #${colors.on_primary};
@define-color secondary #${colors.secondary};
@define-color on_secondary #${colors.on_primary};
@define-color surface #${colors.surface};
@define-color surface_container #${colors.surface_container};
@define-color surface_bright #${colors.surface_bright};
@define-color error #${colors.error};'';
}
