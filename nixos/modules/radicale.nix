{...}: {
  services.radicale = {
    enable = true;
    settings = {
      # Bind on all interfaces so LAN clients (and Tailscale later) can reach it.
      server.hosts = ["0.0.0.0:5232"];

      auth = {
        type = "htpasswd";
        htpasswd_filename = "/var/lib/radicale/users";
        htpasswd_encryption = "bcrypt";
      };

      storage.filesystem_folder = "/var/lib/radicale/collections";
    };
  };

  # LAN only — the router does not forward this port. Opening it here also lets
  # a future Tailscale setup reach the server without extra firewall rules.
  networking.firewall.allowedTCPPorts = [5232];
}
