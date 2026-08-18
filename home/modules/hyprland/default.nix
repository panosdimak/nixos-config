{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Symlink the quickshell-overview module files into ~/.config/quickshell/overview.
  # recursive = true so the directory is real and the user can drop in a config.json
  # alongside the read-only symlinks if they want to override defaults.
  xdg.configFile."quickshell/overview" = {
    source = inputs.quickshell-overview;
    recursive = true;
  };

  # Hyprland (user-scoped config via Home Manager)
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    systemd.enable = true;

    configType = "lua";

    plugins = [
      # inputs.hyprtasking.packages.${pkgs.stdenv.hostPlatform.system}.hyprtasking
    ];

    settings = {
      # Autostart, rendered as a Lua local that hyprland.lua loops over in its
      # hyprland.start hook — Hyprland's Lua API has no exec-once. Hosts append
      # to this list the way they used to append to exec-once.
      autostart._var = [
        "waypaper --restore"
        "nm-applet"
        "blueman-applet"
        "hypridle"
        "vicinae server"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "vesktop --start-minimized"
        "qs -c overview"
      ];

      # Each _args pair becomes one hl.env(name, value) call.
      env = [
        {_args = ["TERMINAL" "kitty"];}
        {_args = ["XDG_CURRENT_DESKTOP" "Hyprland"];}
        {_args = ["XDG_SESSION_TYPE" "wayland"];}
        {_args = ["GTK_USE_PORTAL" "1"];}
        {_args = ["QT_QPA_PLATFORM" "wayland"];}
        {_args = ["MOZ_ENABLE_WAYLAND" "1"];}
        {_args = ["SDL_VIDEODRIVER" "wayland"];}
        {_args = ["CLUTTER_BACKEND" "wayland"];}
        {_args = ["HYPRCURSOR_THEME" "Bibata-Modern-Classic"];}
        {_args = ["HYPRCURSOR_SIZE" "24"];}
        {_args = ["XCURSOR_THEME" "Bibata-Modern-Classic"];}
        {_args = ["XCURSOR_SIZE" "24"];}
        # Where hyprshot saves; also read by the SUPER+SHIFT+D bind. hyprshot
        # otherwise falls back to $HOME, since xdg-user-dir isn't installed.
        {_args = ["HYPRSHOT_DIR" "${config.home.homeDirectory}/Pictures/Screenshots"];}
        {
          _args = [
            "NIX_PROFILES"
            "/etc/profiles/per-user/${config.home.username} /run/current-system/sw /nix/var/nix/profiles/default ${config.home.homeDirectory}/.local/state/nix/profile /nix/profile ${config.home.homeDirectory}/.nix-profile"
          ];
        }
      ];
    };

    # Binds, window/layer rules, animations and gestures. Kept as Lua because
    # they lean on locals, a loop and callbacks that Nix can only pass through
    # as opaque strings.
    extraConfig = builtins.readFile ./hyprland.lua;
  };
}
