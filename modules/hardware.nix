{ pkgs, ... }:

{
  # Trim support for SSDs
  services.fstrim.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # show battery charge of Bluetooth devices
      };
    };
  };

  # 32-bit OpenGL/Vulkan for Wine plugin UIs (new-style options)
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
