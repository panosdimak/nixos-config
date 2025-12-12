{ pkgs, ... }:
{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
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
    clang-tools
    git
    ripgrep
    fzf
    bat
    vscode
    zed-editor
    lazygit

    nixd
    alejandra

    # language servers
    lua-language-server
    bash-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver
  ];
}
