{ ... }:

{
  imports = [
    ./ryzen-desktop-hardware.nix

    ../modules/boot.nix
    ../modules/hardware.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/system.nix
    ../modules/security.nix
    ../modules/desktop/plasma.nix
    ../modules/desktop/common.nix
    ../modules/hyprland/hyprland.nix
    ../modules/nvidia.nix
    ../modules/advanced-audio.nix
    ../modules/users/panos.nix
    ../modules/programs/common.nix
    ../modules/stylix.nix
  ];

  system.stateVersion = "25.05";
}