{...}: {
  services.openssh = {
    enable = true;
    openFirewall = false; # reachable over Tailscale only
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["panos"];
    };
  };

  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [22];

  users.users.panos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPf6XHL2DMy8LTtM5yh8SQ2ZEV/CnXs9tq2M2JxLXdfJ panos@inspiron-15"
  ];
}
