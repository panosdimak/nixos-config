{pkgs, ...}: {
  services.tailscale = {
    enable = true;
    openFirewall = true; # UDP 41641, for direct peer-to-peer instead of relays
  };

  # Mullvad's firewall drops Tailscale traffic. Tag it with Mullvad's
  # split-tunnel marks so it bypasses the VPN: traffic to/from the tailnet
  # range, plus tailscaled's own packets (fwmark 0x80000).
  systemd.services.mullvad-tailscale-exclude = {
    description = "Exclude Tailscale traffic from Mullvad";
    wantedBy = ["multi-user.target"];
    after = ["nftables.service" "firewall.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.nftables}/bin/nft -f ${pkgs.writeText "mullvad-tailscale.nft" ''
        table inet mullvad-tailscale {
          chain prerouting {
            type filter hook prerouting priority -100; policy accept;
            ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }
          chain outgoing {
            type route hook output priority -100; policy accept;
            meta mark 0x80000 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }
        }
      ''}";
      ExecStop = "${pkgs.nftables}/bin/nft delete table inet mullvad-tailscale";
    };
  };
}
