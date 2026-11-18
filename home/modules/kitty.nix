{...}: {
  programs.kitty = {
    enable = true;

    # Disable HM's shell integration injection — preserve prior behavior.
    shellIntegration.mode = null;

    settings = {
      font_size = 10;

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
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+equal" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+shift+p" = "kitten hints";
      # Open in the current window's directory. Inside `kitten ssh` this also
      # opens on the same remote host.
      "ctrl+shift+enter" = "launch --cwd=current";
      "ctrl+shift+t" = "launch --type=tab --cwd=current";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
    };

    # Matugen-managed dynamic colors (written at runtime by wallpaper-theme.sh).
    extraConfig = ''
      include colors.conf
    '';
  };

  # kitten ssh is supposed to inherit shell_integration from kitty.conf, but
  # here it sends nothing, so remote shells start without integration and
  # can't report their cwd (needed for launch --cwd=current over SSH).
  xdg.configFile."kitty/ssh.conf".text = ''
    shell_integration enabled
  '';
}
