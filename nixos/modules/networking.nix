{ ... }:

{
  networking.networkmanager.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
}
