{ lib, pkgs, ... }:

{
  systemd.services."systemd-suspend".serviceConfig = {
    ExecStartPre = lib.mkAfter "${pkgs.systemd}/bin/loginctl lock-sessions";
    Environment  = "SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false";
  };

  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults env_keep += "EDITOR VISUAL"
    '';
  };
}
