{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/kitty-colors.conf".text = ''
      cursor                {{colors.primary.default.hex}}
      cursor_text_color     {{colors.on_primary.default.hex}}

      background            {{colors.surface.default.hex}}
      foreground            {{colors.on_surface.default.hex}}
      selection_foreground  {{colors.on_primary.default.hex}}
      selection_background  {{colors.primary.default.hex}}
      url_color             {{colors.primary.default.hex}}

      color0  {{colors.surface.default.hex}}
      color1  {{colors.error.default.hex}}
      color2  {{colors.tertiary.default.hex}}
      color3  {{colors.secondary.default.hex}}
      color4  {{colors.primary.default.hex}}
      color5  {{colors.tertiary_fixed_dim.default.hex}}
      color6  {{colors.secondary_fixed_dim.default.hex}}
      color7  {{colors.on_surface.default.hex}}
      color8  {{colors.outline.default.hex}}
      color9  {{colors.on_error_container.default.hex}}
      color10 {{colors.on_tertiary_container.default.hex}}
      color11 {{colors.on_secondary_container.default.hex}}
      color12 {{colors.on_primary_container.default.hex}}
      color13 {{colors.tertiary_fixed.default.hex}}
      color14 {{colors.secondary_fixed.default.hex}}
      color15 {{colors.surface_bright.default.hex}}
    '';
  };

  fallback = createIfMissing "${configHome}/kitty/colors.conf" ''
cursor #${colors.on_surface}
cursor_text_color #${colors.on_surface_variant}
foreground #${colors.on_surface}
background #${colors.surface}
selection_foreground #${colors.on_primary}
selection_background #${colors.secondary}
url_color #${colors.primary}
color0 #${colors.surface}
color1 #${colors.error}
color2 #8aac8b
color3 #${colors.secondary}
color4 #${colors.primary}
color5 #ac8aac
color6 #8aacab
color7 #${colors.on_surface}
color8 #${colors.outline}
color9 #${colors.error}
color10 #8aac8b
color11 #${colors.secondary}
color12 #${colors.primary}
color13 #ac8aac
color14 #8aacab
color15 #${colors.on_surface}'';
}
