{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/swaync-colors.css".text = ''
      @define-color background #{{colors.surface.default.hex_stripped}};
      @define-color foreground #{{colors.on_surface.default.hex_stripped}};
      @define-color primary #{{colors.primary.default.hex_stripped}};
      @define-color secondary #{{colors.secondary.default.hex_stripped}};
      @define-color surface #{{colors.surface_container.default.hex_stripped}};
      @define-color error #{{colors.error.default.hex_stripped}};
      @define-color border #{{colors.outline.default.hex_stripped}};
    '';
  };

  fallback = createIfMissing "${configHome}/swaync/colors.css" ''
@define-color background #${colors.surface};
@define-color foreground #${colors.on_surface};
@define-color primary #${colors.primary};
@define-color secondary #${colors.secondary};
@define-color surface #${colors.surface_container};
@define-color error #${colors.error};
@define-color border #${colors.outline};'';
}
