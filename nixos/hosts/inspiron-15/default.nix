{ pkgs, ... }:

{
  imports = [
    ./hardware.nix

  # Common system profile used by all hosts
  ../../profiles/common.nix

  # Host-specific hardware/stack choices
  ../../modules/intel.nix
  ../../modules/audio.nix
  ../../modules/power-management.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "inspiron-15";

  # Choose display manager for this host
  profiles.displayManager = {
    dm = "gdm";
    wayland = true;
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";
}