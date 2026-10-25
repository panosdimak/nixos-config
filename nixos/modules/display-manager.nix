{lib, ...}: {
  services.displayManager.dux-greeter = {
    enable = true;
    compositor.name = "hyprland";

    compositor.customConfig = ''
      env = DMS_RUN_GREETER,1

      misc {
          force_default_wallpaper = 0
          disable_hyprland_logo = true
          disable_splash_rendering = true
      }
    '';

    configHome = "/home/panos";
  };

  services.displayManager.defaultSession = "hyprland";

  # Upstream uses Type=idle, which holds the greeter back until every boot job
  # settles (wait-online, coolercontrold). Nothing writes to the tty here, so
  # there is no console output to protect.
  systemd.services.greetd.serviceConfig.Type = lib.mkForce "simple";
}
