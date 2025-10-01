{ pkgs, ... }:
{  
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
      silent = true;
    };
  };

  # Development-centric packages
  home.packages = with pkgs; [
    gcc
    gnumake
    valgrind
    binutils
    git
    ripgrep
    fzf
    bat
    vscode
  ];
}