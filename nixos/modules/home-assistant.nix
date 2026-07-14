{...}: {
  services.home-assistant = {
    enable = true;

    extraComponents = [
      "gree" # the Toyotomi/Gree AC, over its local UDP protocol
      "default_config"
      "met" # weather - required for onboarding
      "radio_browser" # also required for onboarding
      "analytics"
    ];

    config = {
      default_config = {};
      homeassistant = {
        unit_system = "metric";
        time_zone = "Europe/Athens";
      };
    };

    openFirewall = true; # opens TCP 8123 for the web UI / phone app
  };

  # Gree auto-discovery: greeclimate broadcasts a scan to :7000 from an
  # ephemeral local port, and the AC answers by unicast *from* :7000 back to
  # that ephemeral port. The stateful firewall can't tie that reply to the
  # broadcast we sent, so it arrives as unsolicited traffic on an unopened port
  # and gets dropped — which is why simply opening inbound 7000 does nothing.
  # Accept UDP replies whose source port is 7000 (only the AC uses it here).
  # Ongoing control traffic is plain unicast and already allowed by conntrack.
  networking.firewall.extraCommands = ''
    iptables -I nixos-fw -p udp --sport 7000 -j nixos-fw-accept
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D nixos-fw -p udp --sport 7000 -j nixos-fw-accept 2>/dev/null || true
  '';
}
