{lib, ...}: {
  networking.networkmanager.enable = true;

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  # Encrypted DNS via Quad9. The "#dns.quad9.net" suffix is the cert name.
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
        "2620:fe::fe#dns.quad9.net"
        "2620:fe::9#dns.quad9.net"
      ];
      DNSOverTLS = "true";
      # Quad9 validates upstream; resolved's validator trips on their test name
      DNSSEC = "false";
      # systemd's fallbacks are Cloudflare and Google, in the clear
      FallbackDNS = [];
    };
  };

  # Otherwise NM hands resolved the DHCP resolver as a per-link server, and
  # link servers race the global Quad9 ones — bypassing DoT.
  networking.networkmanager.dns = lib.mkForce "none";

  networking.firewall = {
    # LocalSend
    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];

    # KDE Connect
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
