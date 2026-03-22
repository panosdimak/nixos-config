#!/usr/bin/env bash
# Wallpaper theme script - generates colors from current wallpaper
# This is called by waypaper's post_command after setting a new wallpaper
# App reloads are handled by matugen's post_hook in config.toml
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

# Create/update symlink for hyprlock to use
ln -sf "$WALLPAPER" "$CACHE_HOME/current_wallpaper"

echo "Generating theme from: $WALLPAPER"

# Run matugen to generate colors and reload apps (via post_hook in config.toml)
matugen image "$WALLPAPER" --mode dark --source-color-index 0

echo "Theme updated successfully"
