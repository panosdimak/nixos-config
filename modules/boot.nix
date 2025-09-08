{ pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "keep";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;

  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ "lz4" ];
  boot.plymouth.enable = false;

  boot.kernelParams = [ 
    "usbcore.autosuspend=-1" 
    "zswap.enabled=1"
    "zswap.compressor=lz4"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
}