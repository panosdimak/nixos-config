{ config, lib, pkgs, ... }:

# Matugen dynamic theming module
#
# Architecture:
# - Templates are stored in ~/.config/matugen/templates/
# - matugen processes templates and outputs to app config dirs (waybar, hypr, etc.)
# - waypaper's post_command triggers: wallpaper-theme.sh $wallpaper
# - The script runs matugen and reloads apps
#
# On first boot, fallback colors are created so apps don't break before
# matugen runs for the first time.

let
  # Default Catppuccin Mocha colors for fallback
  colors = {
    surface = "1e1e2e";
    surface_container = "313244";
    surface_container_low = "1e1e2e";
    surface_container_high = "45475a";
    surface_container_highest = "585b70";
    surface_bright = "45475a";
    surface_variant = "585b70";
    on_surface = "cdd6f4";
    on_surface_variant = "a6adc8";
    primary = "89b4fa";
    primary_fixed_dim = "74c7ec";
    on_primary = "1e1e2e";
    on_primary_fixed = "1e1e2e";
    inverse_primary = "1e66f5";
    secondary = "f5c2e7";
    tertiary = "f5c2e7";
    tertiary_container = "585b70";
    tertiary_fixed = "f5c2e7";
    tertiary_fixed_dim = "f2cdcd";
    on_tertiary_fixed = "1e1e2e";
    error = "f38ba8";
    outline = "6c7086";
    surface_container_lowest = "11111b";
    surface_dim = "181825";
    inverse_on_surface = "313244";
  };

  # Helper to create a default color file if it doesn't exist
  createIfMissing = path: content: ''
    if [ ! -f "${path}" ]; then
      mkdir -p "$(dirname "${path}")"
      cat > "${path}" << 'COLOREOF'
${content}
COLOREOF
    fi
  '';

  configHome = config.xdg.configHome;

  # Shared args passed to each program module
  args = { inherit colors createIfMissing configHome config; };

  hyprland = import ./hyprland.nix args;
  waybar = import ./waybar.nix args;
  fuzzel = import ./fuzzel.nix args;
  swaync = import ./swaync.nix args;
  gtk = import ./gtk.nix args;
  kitty = import ./kitty.nix args;
  starship = import ./starship.nix args;
  vesktop = import ./vesktop.nix args;
  zed = import ./zed.nix args;
  neovim = import ./neovim.nix args;
  vicinae = import ./vicinae.nix args;
  quickshell = import ./quickshell.nix args;
in
{
  xdg.configFile =
    {
      # Main matugen config
      "matugen/config.toml".text = ''
        [config]
        reload_apps = false  # We handle reloads in wallpaper-theme.sh

        [templates.hyprland]
        input_path = "${configHome}/matugen/templates/hyprland-colors.conf"
        output_path = "${configHome}/hypr/colors.conf"

        [templates.waybar]
        input_path = "${configHome}/matugen/templates/waybar-colors.css"
        output_path = "${configHome}/waybar/colors.css"

        [templates.fuzzel]
        input_path = "${configHome}/matugen/templates/fuzzel-colors.ini"
        output_path = "${configHome}/fuzzel/colors.ini"

        [templates.swaync]
        input_path = "${configHome}/matugen/templates/swaync-colors.css"
        output_path = "${configHome}/swaync/colors.css"

        [templates.gtk3]
        input_path = "${configHome}/matugen/templates/gtk.css"
        output_path = "${configHome}/gtk-3.0/colors.css"

        [templates.gtk4]
        input_path = "${configHome}/matugen/templates/gtk.css"
        output_path = "${configHome}/gtk-4.0/colors.css"

        [templates.vesktop]
        input_path = "${configHome}/matugen/templates/vesktop.css"
        output_path = "${configHome}/vesktop/themes/midnight-discord.css"

        [templates.kitty]
        input_path = "${configHome}/matugen/templates/kitty-colors.conf"
        output_path = "${configHome}/kitty/colors.conf"

        [templates.starship]
        input_path = "${configHome}/matugen/templates/starship.toml"
        output_path = "${configHome}/starship.toml"

        [templates.vicinae]
        input_path = "${configHome}/matugen/templates/vicinae.toml"
        output_path = "${config.home.homeDirectory}/.local/share/vicinae/themes/matugen.toml"

        [templates.neovim]
        input_path = "${configHome}/matugen/templates/nvim-colors.lua"
        output_path = "${configHome}/nvim/matugen-colors.lua"

        [templates.zed]
        input_path = "${configHome}/matugen/templates/zed-colors.json"
        output_path = "${configHome}/zed/themes/matugen.json"

        [templates.quickshell]
        input_path = "${configHome}/matugen/templates/quickshell-colors.qml"
        output_path = "${configHome}/quickshell/overview/common/Appearance.colors.qml"
      '';
    }
    // hyprland.configFile
    // waybar.configFile
    // fuzzel.configFile
    // swaync.configFile
    // gtk.configFile
    // kitty.configFile
    // starship.configFile
    // neovim.configFile
    // vesktop.configFile
    // zed.configFile
    // vicinae.configFile
    // quickshell.configFile;

  # Create fallback color files on first boot (before matugen runs)
  home.activation.createDefaultColors = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${hyprland.fallback}
    ${waybar.fallback}
    ${fuzzel.fallback}
    ${swaync.fallback}
    ${gtk.fallback}
    ${kitty.fallback}
    ${neovim.fallback}
    ${vesktop.fallback}
    ${vicinae.fallback}
    ${zed.fallback}
    ${starship.fallback}
    ${quickshell.fallback}
  '';
}
