{ pkgs, inputs, ... }:
{

  # Common packages and settings (moved from home/common.nix)
  home.username = "panos";
  home.homeDirectory = "/home/panos";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Development tools
    gcc gnumake coreutils gnused gawk findutils bashInteractive binutils
    git git-credential-manager curl wget unzip tree fastfetch
    
    # Editors / IDE / Writing
    obsidian vscode onlyoffice-desktopeditors evince xfce.mousepad

    # Terminal / Shell
    ghostty starship ripgrep fzf bat lsd procs nnn
    ncdu duf dust hyperfine 

    # Clipboard / Screenshot / OCR
    wl-clipboard grim slurp tesseract

    # Media
    mpv obs-studio gapless loupe
   
    # Internet
    inputs.zen-browser.packages.${pkgs.system}.twilight
    vesktop telegram-desktop signal-desktop qbittorrent protonvpn-gui

    # System utilities
    nautilus xfce.thunar xfce.thunar-archive-plugin xfce.thunar-volman numlockx  qpwgraph  
    btop cpuid cpu-x hardinfo2 mission-center resources
    kdePackages.kalk warp

    # Tools
    localsend

    # Misc
    sl cowsay fortune lolcat
  ];
  
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };

  services.syncthing.enable = true;
  programs.home-manager.enable = true;
}
