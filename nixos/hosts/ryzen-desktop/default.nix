{ pkgs, ... }:

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

  profiles.displayManager = {
    dm = "gdm";
    wayland = true;
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";

  profiles.audio.lowLatency = true;

  programs.steam.enable = true;
  programs.wireshark.enable = true;
  users.users.panos.extraGroups = [ "wireshark" ];
}
