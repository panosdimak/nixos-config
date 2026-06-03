{...}: {
  programs.kitty = {
    enable = true;

    # Disable HM's shell integration injection — preserve prior behavior.
    shellIntegration.mode = null;

    settings = {
      background_opacity = "0.7";
      dynamic_background_opacity = true;
      hide_window_decorations = true;
      confirm_os_window_close = 0;
      window_padding_width = 6;

      scrollback_lines = 10000;
      enable_audio_bell = false;

      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_trail = 10;
      cursor_trail_start_threshold = 0;
      cursor_trail_decay = "0.01 0.05";

      allow_remote_control = true;
      listen_on = "unix:/tmp/kitty-$PPID";

      # Disable the config hot-reload watcher (negative value = off). Under Home
      # Manager ~/.config/kitty is a symlink into /nix/store, and kitty 0.47.1
      # resolves it and recursively inotify-watches the whole store, exhausting
      # fs.inotify.max_user_watches and starving other apps (Obsidian, editors).
      # See kitty#10066/#10104. Fixed upstream after 0.47.1, so this can return to
      # the 0.1 default once kitty updates. Reload manually with ctrl+shift+f5.
      auto_reload_config = -1;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+equal" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+shift+p" = "kitten hints";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
    };

    # Matugen-managed dynamic colors (written at runtime by wallpaper-theme.sh).
    extraConfig = ''
      include colors.conf
    '';
  };
}
