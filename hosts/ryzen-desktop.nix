{ ... }:

{
  imports = [
    ./ryzen-desktop-hardware.nix

    ../modules/boot.nix
    ../modules/hardware.nix
    ../modules/amd.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/system.nix
    ../modules/security.nix
    ../modules/desktop/plasma.nix
    ../modules/desktop/portals-plasma.nix
    ../modules/desktop/portals-hyprland.nix
    ../modules/hyprland.nix
    ../modules/nvidia.nix
    ../modules/graphics-32bit.nix
    ../modules/advanced-audio.nix
    ../modules/users/panos.nix
    ../modules/programs/common.nix
    ../modules/programs/gaming.nix
    ../modules/stylix.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "ryzen-desktop";

}