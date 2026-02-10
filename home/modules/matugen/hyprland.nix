{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/hyprland-colors.conf".text = ''
      # Matugen-generated Hyprland colors
      $background = rgb({{colors.surface.default.hex_stripped}})
      $foreground = rgb({{colors.on_surface.default.hex_stripped}})
      $primary = rgb({{colors.primary.default.hex_stripped}})
      $on_primary = rgb({{colors.on_primary.default.hex_stripped}})
      $secondary = rgb({{colors.secondary.default.hex_stripped}})
      $surface = rgb({{colors.surface.default.hex_stripped}})
      $surface_container = rgb({{colors.surface_container.default.hex_stripped}})
      $error = rgb({{colors.error.default.hex_stripped}})
      $active_border = rgba({{colors.primary.default.hex_stripped}}ff)
      $inactive_border = rgba({{colors.outline.default.hex_stripped}}80)
      $hyprtaskingBg = 0xff{{colors.surface.default.hex_stripped}}
    '';
  };

  fallback = createIfMissing "${configHome}/hypr/colors.conf" ''
$background = rgb(${colors.surface})
$foreground = rgb(${colors.on_surface})
$primary = rgb(${colors.primary})
$on_primary = rgb(${colors.on_primary})
$secondary = rgb(${colors.secondary})
$surface = rgb(${colors.surface})
$surface_container = rgb(${colors.surface_container})
$error = rgb(${colors.error})
$active_border = rgba(${colors.primary}ff)
$inactive_border = rgba(${colors.outline}80)
$hyprtaskingBg = 0xff${colors.surface}'';
}
