{ pkgs, inputs, ... }:
{

  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
  ];

  programs.dms-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
    };
  };
}
