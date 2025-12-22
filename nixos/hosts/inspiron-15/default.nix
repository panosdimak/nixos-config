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


  services.udev.extraRules = ''
    # Autosuspend webcam
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0c45", ATTR{idProduct}=="6730", TEST=="power/control", ATTR{power/control}="auto"

    # Autosuspend Intel AX201 Bluetooth USB interface
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0026", TEST=="power/control", ATTR{power/control}="auto"
  '';

  # Choose display manager for this host
  profiles.displayManager = {
    dm = "gdm";
    wayland = true;
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
}
