{ ... }:
{
  imports = [
    ./hardware.nix

  # Common system profile used by all hosts
  ../../profiles/common.nix

  # Host-specific hardware/stack choices
  ../../modules/amd.nix
  ../../modules/security.nix
  ../../modules/nvidia.nix
  ../../modules/graphics-32bit.nix
  ../../modules/advanced-audio.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "ryzen-desktop";

  profiles.displayManager = {
    dm = "gdm";
    wayland = true;
  };
}