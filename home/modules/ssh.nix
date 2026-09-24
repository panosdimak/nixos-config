{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      ForwardAgent = false;
      AddKeysToAgent = "confirm"; # adds keys but asks for approval
      Compression = false;
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
      HashKnownHosts = true;
      UserKnownHostsFile = "~/.ssh/known_hosts";

      # Multiplexing for fast Git/SSH connections
      ControlMaster = "auto";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ControlPersist = "10m"; # keep master open for 10 minutes
    };

    settings."github.com" = {
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519";
    };
  };
}
