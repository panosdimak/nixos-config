{ ... }:
{
  # Shared, host-agnostic system modules imported by all machines.
  imports = [
    ../modules/boot.nix
    ../modules/hardware.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/system.nix
    ../modules/portals.nix
    ../modules/security.nix
    ../modules/secret-service.nix
    ../modules/hyprland.nix
    ../modules/users/panos.nix
    ../modules/programs/common.nix
    ../modules/stylix.nix
    ../modules/display-manager.nix
  ];
}