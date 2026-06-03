{...}: {
  services.displayManager.dms-greeter = {
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
}
