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

    # configuration.yaml is a read-only store symlink; without these includes
    # the UI editors have nowhere writable to save and just hang.
    config = {
      default_config = {};
      homeassistant = {
        unit_system = "metric";
        time_zone = "Europe/Athens";
      };
      "automation ui" = "!include automations.yaml";
      "script ui" = "!include scripts.yaml";
      "scene ui" = "!include scenes.yaml";
    };
  };

  # !include fails hard on a missing file. Seeds once; tmpfiles won't rewrite.
  systemd.tmpfiles.settings."10-home-assistant" = let
    seed.f = {
      user = "hass";
      group = "hass";
      mode = "0644";
      argument = "[]";
    };
  in {
    "/var/lib/hass/automations.yaml" = seed;
    "/var/lib/hass/scripts.yaml" = seed;
    "/var/lib/hass/scenes.yaml" = seed;
  };

  # The module dropped its own openFirewall — the port isn't known at eval time.
  networking.firewall.allowedTCPPorts = [8123];

  # greeclimate scans :7000 from an ephemeral port and the AC replies *from*
  # :7000, which conntrack can't match — opening inbound 7000 does nothing.
  networking.firewall.extraCommands = ''
    iptables -I nixos-fw -p udp --sport 7000 -j nixos-fw-accept
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D nixos-fw -p udp --sport 7000 -j nixos-fw-accept 2>/dev/null || true
  '';
}
