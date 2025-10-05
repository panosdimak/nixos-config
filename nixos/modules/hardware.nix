{ ... }:

{
  # Trim support for SSDs
  services.fstrim.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true; # show battery charge of Bluetooth devices
      };
    };
  };
  
}
