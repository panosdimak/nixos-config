{...}: {
  # Idle daemon only. The lock screen itself is DMS's, so hypridle just calls
  # out to it — there is no hyprlock config to go with this.
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "dms ipc call lock lock";
        inhibit_sleep = 3;
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;
      };
    };
  };
}
