{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
  ];

  programs.dux-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dux-shell changes
    };
  };

  programs.dux-files = {
    enable = true;
    systemd.enable = true; # Resident instance so windows and file dialogs open instantly
    portal.enable = true;
  };

  # Use Dux Files for open/save dialogs; gtk stays as the fallback
  xdg.portal.config.common."org.freedesktop.impl.portal.FileChooser" = ["dfiles" "gtk"];

  # GTK3 apps only ask the portal for file dialogs when this is set. It has to be a
  # session variable so apps started from the DMS launcher (a systemd service) see it,
  # not just ones Hyprland spawns directly.
  environment.sessionVariables.GTK_USE_PORTAL = "1";
}
