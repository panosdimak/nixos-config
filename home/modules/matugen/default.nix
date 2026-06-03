{
  config,
  lib,
  pkgs,
  ...
}:
# Matugen dynamic theming module
#
# DMS owns wallpaper selection and runs matugen natively on every wallpaper
# change. matugen reads ~/.config/matugen/config.toml, renders each template
# under templates/ against the new palette, and writes the result into the
# target app's config dir; some targets reload live via a post_hook.
#
# config.toml and the templates are plain checked-in files under ./files,
# symlinked into ~/.config/matugen. To add a target: drop a template in
# files/templates/ and add a [templates.*] block to files/config.toml.
let
  configHome = config.xdg.configHome;
in {
  xdg.configFile = {
    "matugen/config.toml".source = ./files/config.toml;
    "matugen/templates".source = ./files/templates;
  };

  # The rendered vesktop theme only takes effect once it's listed in Vencord's
  # enabledThemes, so make sure it's there (creating settings.json if absent).
  home.activation.vesktopTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    VENCORD_SETTINGS="${configHome}/vesktop/settings/settings.json"
    if [ -f "$VENCORD_SETTINGS" ]; then
      if ! grep -q '"midnight-discord.css"' "$VENCORD_SETTINGS"; then
        ${pkgs.jq}/bin/jq '.enabledThemes = ((.enabledThemes // []) + ["midnight-discord.css"] | unique)' \
          "$VENCORD_SETTINGS" > "$VENCORD_SETTINGS.tmp" && mv "$VENCORD_SETTINGS.tmp" "$VENCORD_SETTINGS"
      fi
    else
      mkdir -p "$(dirname "$VENCORD_SETTINGS")"
      echo '{"enabledThemes":["midnight-discord.css"]}' > "$VENCORD_SETTINGS"
    fi
  '';
}
