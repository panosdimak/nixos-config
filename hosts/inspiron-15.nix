{
  imports = [
    ./inspiron-15-hardware.nix

    ../modules/boot.nix
    ../modules/hardware.nix
    ../modules/intel.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/system.nix
    ../modules/portals.nix
    ../modules/secret-service.nix
    ../modules/hyprland.nix
    ../modules/audio.nix
    ../modules/users/panos.nix
    ../modules/programs/common.nix
    ../modules/stylix.nix
    ../modules/display-manager.nix
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