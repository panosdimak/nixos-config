{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/fuzzel-colors.ini".text = ''
      [colors]
      background={{colors.surface.default.hex_stripped}}dd
      text={{colors.on_surface.default.hex_stripped}}ff
      prompt={{colors.primary.default.hex_stripped}}ff
      placeholder={{colors.on_surface_variant.default.hex_stripped}}aa
      input={{colors.on_surface.default.hex_stripped}}ff
      match={{colors.primary.default.hex_stripped}}ff
      selection={{colors.primary_container.default.hex_stripped}}ff
      selection-text={{colors.on_primary_container.default.hex_stripped}}ff
      selection-match={{colors.primary.default.hex_stripped}}ff
      counter={{colors.on_surface_variant.default.hex_stripped}}ff
      border={{colors.outline.default.hex_stripped}}ff
    '';
  };

  fallback = createIfMissing "${configHome}/fuzzel/colors.ini" ''
[colors]
background=${colors.surface}dd
text=${colors.on_surface}ff
prompt=${colors.primary}ff
placeholder=${colors.on_surface_variant}aa
input=${colors.on_surface}ff
match=${colors.primary}ff
selection=${colors.surface_container}ff
selection-text=${colors.on_surface}ff
selection-match=${colors.primary}ff
counter=${colors.on_surface_variant}ff
border=${colors.outline}ff'';
}
