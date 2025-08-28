{ pkgs, ... }:

{
  # Filesystem mounts that aren’t in hardware-configuration.nix
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/7C14A40114A3BD10";
    fsType = "ntfs";
    options = [ "uid=1000" "gid=100" "umask=002" ];
  };

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
}
