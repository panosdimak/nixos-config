{...}:

{
  imports = [
    ./hardware.nix

  # Common system profile used by all hosts
  ../../profiles/common.nix

  # Host-specific hardware/stack choices
  ../../modules/amd.nix
  ../../modules/nvidia.nix
  ../../modules/graphics-32bit.nix
  ../../modules/audio.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "ryzen-desktop";

  profiles.audio.lowLatency = true;

  programs.steam.enable = true;
}
