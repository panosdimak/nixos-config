{...}: {
  programs.kitty = {
    enable = true;

    # Disable HM's shell integration injection — preserve prior behavior.
    shellIntegration.mode = null;

    settings = {
      background_opacity = "0.8";
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
