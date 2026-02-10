{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    # Midnight Discord v2.1.1 theme with matugen Material You colors
    "matugen/templates/vesktop.css".text = builtins.readFile ./templates/vesktop.css;
  };

  fallback = ''
    ${createIfMissing "${configHome}/vesktop/themes/midnight-discord.css" ''
/**
 * @name midnight (vencord)
 * @description a dark, customizable discord theme with Material You colors.
 * @version 2.1.1
 */

@import url('https://refact0r.github.io/midnight-discord/build/midnight.css');

body {
  --font: "";
  --code-font: "";
}

:root {
  --colors: on;
  --text-0: #${colors.surface};
  --text-1: #ffffff;
  --text-2: #dcddde;
  --text-3: #dcddde;
  --text-4: #949ba4;
  --text-5: #72767d;
  --bg-1: #${colors.surface_bright};
  --bg-2: #${colors.surface_container_highest};
  --bg-3: #${colors.surface_container_high};
  --bg-4: #${colors.surface};
  --hover: #${colors.surface_bright};
  --active: #${colors.surface_bright};
  --accent-1: #${colors.tertiary};
  --accent-2: #${colors.primary};
  --accent-3: #${colors.primary};
  --blue-1: #${colors.primary};
  --blue-2: #${colors.primary};
  --blue-3: #${colors.primary};
  --blue-4: #${colors.primary};
  --blue-5: #${colors.primary};
  --red-1: #${colors.error};
  --red-2: #${colors.error};
  --red-3: #${colors.error};
  --red-4: #${colors.error};
  --red-5: #${colors.error};
}''}

    # Ensure midnight-discord.css is in Vencord's enabledThemes
    VENCORD_SETTINGS="${configHome}/vesktop/settings/settings.json"
    if [ -f "$VENCORD_SETTINGS" ]; then
      if ! grep -q '"midnight-discord.css"' "$VENCORD_SETTINGS"; then
        jq '.enabledThemes = ((.enabledThemes // []) + ["midnight-discord.css"] | unique)' \
          "$VENCORD_SETTINGS" > "$VENCORD_SETTINGS.tmp" && mv "$VENCORD_SETTINGS.tmp" "$VENCORD_SETTINGS"
      fi
    else
      mkdir -p "$(dirname "$VENCORD_SETTINGS")"
      echo '{"enabledThemes":["midnight-discord.css"]}' > "$VENCORD_SETTINGS"
    fi
  '';
}
