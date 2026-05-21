{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
  ];

  programs.dms-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };
  };

  # Use exclusive keyboard focus on the layer surface instead of HyprlandFocusGrab.
  # Why: workspace dispatches from the overview break the grab, which closes the
  # overlay mid-interaction (arrows stop working after one press, Escape can't
  # fire). See HyprlandOverview.qml + CompositorService.qml in dms-shell.
  systemd.user.services.dms.environment.DMS_HYPRLAND_EXCLUSIVE_FOCUS = "1";
}
