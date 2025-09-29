{ lib, pkgs, ... }:

{
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults env_keep += "EDITOR VISUAL"
    '';
  };

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "default.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };
}
