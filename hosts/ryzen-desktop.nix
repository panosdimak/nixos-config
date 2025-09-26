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
    # ../modules/desktop/plasma.nix
    ../modules/portals.nix
    ../modules/secret-service.nix
    ../modules/hyprland.nix
    ../modules/nvidia.nix
    ../modules/graphics-32bit.nix
    ../modules/advanced-audio.nix
    ../modules/users/panos.nix
    ../modules/programs/common.nix
    ../modules/programs/gaming.nix
    ../modules/stylix.nix
    ../modules/display-manager.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "ryzen-desktop";

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