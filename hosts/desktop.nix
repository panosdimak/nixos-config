{ config, pkgs, lib, ... }:

{
  imports = [
    ./desktop-hardware.nix

    ../modules/boot.nix
    ../modules/hardware.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/system.nix
    ../modules/security.nix
    ../modules/desktop/plasma.nix
    ../modules/nvidia.nix
    ../modules/audio.nix
    ../modules/users/panos.nix
    ../modules/programs/common.nix
  ];

  # Every host needs this
  system.stateVersion = "25.05";
}
