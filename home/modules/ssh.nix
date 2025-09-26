{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "confirm"; # adds keys but asks for approval
      compression = false;
      serverAliveInterval = 60;
      serverAliveCountMax = 3;
      hashKnownHosts = true;
      userKnownHostsFile = "~/.ssh/known_hosts";
      
      # Multiplexing for fast Git/SSH connections
      controlMaster = "auto";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "10m"; # keep master open for 10 minutes
    };

    matchBlocks."github.com" = {
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
}
