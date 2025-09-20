{ ... }:

{
    programs.bash = {
    enable = true;
    initExtra = ''eval "$(starship init bash)"'';
    shellAliases = {
      nixbuildflake = "sudo nixos-rebuild switch --flake ~/nixos-config#$(hostname)";
      vim = "nvim";
      ls = "lsd";
      tree = "lsd --tree";
    };
  };
}