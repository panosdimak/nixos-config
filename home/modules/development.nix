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
    vscodium
    zed-editor
    lazygit
    gh

    claude-code

    nixd
    alejandra

    # language servers
    lua-language-server
    bash-language-server
    yaml-language-server
    vscode-json-languageserver
  ];
}
