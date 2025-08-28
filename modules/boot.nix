{ config, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "keep";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
}
