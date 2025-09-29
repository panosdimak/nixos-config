{ ... }:
{
  imports = [
    ./hardware.nix

  # Common system profile used by all hosts
  ../../profiles/common.nix

  # Host-specific hardware/stack choices
  ../../modules/intel.nix
  ../../modules/audio.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "inspiron-15";

  # Choose display manager for this host
  profiles.displayManager = {
    dm = "gdm";
    wayland = true;
  };

  # Choose portals for this host
  profiles.portals = {
    session = "hyprland";
    enableGtkFallback = true;
  };
}
