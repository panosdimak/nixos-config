{ ... }:

{
  networking.networkmanager.enable = true;

  networking.firewall = {
    # LocalSend
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];

    # KDE Connect
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
}
