#!/usr/bin/env bash
# Wallpaper theme script - generates colors from current wallpaper and reloads apps
# This is called by waypaper's post_command after setting a new wallpaper
#
# Usage: wallpaper-theme.sh [wallpaper_path]
# If wallpaper_path is provided, use it directly (waypaper passes $wallpaper)
# Otherwise, try to detect from swww cache or waypaper config

set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Get the current wallpaper from swww cache or waypaper config
get_wallpaper_from_cache() {
    local swww_cache="$CACHE_HOME/swww"

    # Try swww cache first
    # swww cache format: [null][filter_name][null][path][null]
    if [[ -d "$swww_cache" ]]; then
        local monitor cache_file
        monitor=$(hyprctl monitors -j 2>/dev/null | jq -r '.[0].name' 2>/dev/null || echo "")

        if [[ -n "$monitor" && -f "$swww_cache/$monitor" ]]; then
            cache_file="$swww_cache/$monitor"
        else
            cache_file=$(find "$swww_cache" -maxdepth 1 -type f 2>/dev/null | head -1)
        fi

        if [[ -n "$cache_file" && -f "$cache_file" ]]; then
            tr '\0' '\n' < "$cache_file" | grep '^/' | head -1
            return 0
        fi
    fi

    # Fallback: waypaper config
    local waypaper_config="$CONFIG_HOME/waypaper/config.ini"
    if [[ -f "$waypaper_config" ]]; then
        local wp
        wp=$(grep -E "^wallpaper\s*=" "$waypaper_config" | cut -d'=' -f2 | tr -d ' ')
        echo "${wp/#\~/$HOME}"
        return 0
    fi

    return 1
}

# Use argument if provided (waypaper passes $wallpaper), otherwise detect
if [[ $# -ge 1 && -n "$1" ]]; then
    WALLPAPER="$1"
else
    WALLPAPER=$(get_wallpaper_from_cache) || {
        echo "Error: Could not determine current wallpaper"
        exit 1
    }
fi

# Expand ~ if present
WALLPAPER="${WALLPAPER/#\~/$HOME}"

if [[ ! -f "$WALLPAPER" ]]; then
    echo "Error: Wallpaper file not found: $WALLPAPER"
    exit 1
fi

echo "Generating theme from: $WALLPAPER"

# Run matugen to generate colors from wallpaper
matugen image "$WALLPAPER" --mode dark

# Wait a moment for files to be written
sleep 0.3

# Reload applications to pick up new colors

# Reload Hyprland config (picks up new colors.conf)
hyprctl reload 2>/dev/null || true

# Extract and set colors for Hyprland AFTER reload
# (reload resets plugin settings to config values, so we set them after)
COLORS_CONF="$CONFIG_HOME/hypr/colors.conf"
if [[ -f "$COLORS_CONF" ]]; then
    # Extract the hex color from $surface = rgb(XXXXXX)
    BG_HEX=$(grep '\$surface = ' "$COLORS_CONF" | sed 's/.*rgb(\([^)]*\)).*/\1/' | tr -d '[:space:]' || echo "")
    if [[ -n "$BG_HEX" ]]; then
        # Set hyprtasking bg_color (format: 0xAARRGGBB)
        hyprctl keyword plugin:hyprtasking:bg_color "0xff${BG_HEX}" 2>/dev/null || true
    fi

    # Extract border colors: $active_border = rgba(XXXXXXff)
    ACTIVE_BORDER=$(grep '\$active_border = ' "$COLORS_CONF" | sed 's/.*rgba(\([^)]*\)).*/\1/' | tr -d '[:space:]' || echo "")
    INACTIVE_BORDER=$(grep '\$inactive_border = ' "$COLORS_CONF" | sed 's/.*rgba(\([^)]*\)).*/\1/' | tr -d '[:space:]' || echo "")

    if [[ -n "$ACTIVE_BORDER" ]]; then
        hyprctl keyword general:col.active_border "rgba(${ACTIVE_BORDER})" 2>/dev/null || true
    fi
    if [[ -n "$INACTIVE_BORDER" ]]; then
        hyprctl keyword general:col.inactive_border "rgba(${INACTIVE_BORDER})" 2>/dev/null || true
    fi
fi

# Reload Waybar (SIGUSR2 reloads styles)
pkill -SIGUSR2 waybar 2>/dev/null || killall -SIGUSR2 waybar 2>/dev/null || true

# Reload SwayNC styles
swaync-client --reload-css 2>/dev/null || true

# Reload Vicinae theme
vicinae theme set matugen 2>/dev/null || true

# Reload Kitty colors (for all running kitty instances)
for socket in /tmp/kitty-*; do
    if [[ -S "$socket" ]]; then
        kitty @ --to unix:"$socket" set-colors --all "$CONFIG_HOME/kitty/colors.conf" 2>/dev/null || true
    fi
done

# Note: GTK and QT apps need to be restarted to pick up new colors
# Vesktop/Discord needs to be restarted to pick up new theme colors
# Fuzzel reads colors on each launch, so it will use new colors automatically
# Starship re-reads its config on each prompt, so new prompts will use new colors

echo "Theme updated successfully"
