{
  config,
  pkgs,
  ...
}: {
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Workaround for nixpkgs#523332: GDM greeter loses gnome-session on PATH
  # and ${pkgs.gdm}/share on XDG_DATA_DIRS, so the kiosk greeter never
  # starts. Remove once nixpkgs#523948 lands.
  security.pam.services.gdm-launch-environment.rules.session.gnome-session-path = {
    order = config.security.pam.services.gdm-launch-environment.rules.session.systemd.order + 50;
    control = "required";
    modulePath = "${config.security.pam.package}/lib/security/pam_env.so";
    settings = {
      conffile = let
        env = config.services.displayManager.generic.environment;
      in
        pkgs.writeText "gdm-launch-environment-env-conf" ''
          PATH                    DEFAULT="''${PATH}:${pkgs.gnome-session}/bin"
          XDG_DATA_DIRS           DEFAULT="''${XDG_DATA_DIRS}:${env.XDG_DATA_DIRS}"
          GDM_X_SERVER_EXTRA_ARGS DEFAULT="${env.GDM_X_SERVER_EXTRA_ARGS}"
        '';
      readenv = 0;
    };
  };
}
