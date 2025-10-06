{ ... }:

{
    programs.bash = {
    enable = true;

    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 10000;
    historyFileSize = 20000;

    initExtra = ''
      eval "$(starship init bash)"
      eval "$(fzf --bash)"
    '';

    shellAliases = {
      # NixOS
      nixbuildflake = "sudo nixos-rebuild switch --flake ~/nixos-config#$(hostname)";
      nixclean = "sudo nix-collect-garbage -d";
      nixoptimize = "nix-store --optimise";

      vim = "nvim";
      
      # ls aliases
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -a";
      lla = "lsd -la";
      tree = "lsd --tree";

      # Quick navigation
      home = "cd ~";
      config = "cd ~/nixos-config";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}