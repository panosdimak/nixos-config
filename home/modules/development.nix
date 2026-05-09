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
    gh

    claude-code
    claude-monitor

    nixd
    alejandra

    # language servers
    lua-language-server
    bash-language-server
    yaml-language-server
    vscode-json-languageserver
  ];
}
