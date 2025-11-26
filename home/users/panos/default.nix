{ pkgs, inputs, ... }:
{

  # Common packages and settings (moved from home/common.nix)
  home.username = "panos";
  home.homeDirectory = "/home/panos";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Core utilities
    coreutils gnused gawk findutils bashInteractive
    curl wget zip unzip tree fastfetch

    # Editors / Writing
    obsidian onlyoffice-desktopeditors evince xfce.mousepad

    # Terminal / Shell
    ghostty starship lsd procs nnn
    ncdu duf dust

    # Clipboard / Screenshot / OCR
    wl-clipboard grim slurp tesseract

    # Media
    mpv obs-studio gapless loupe

    # Internet
    inputs.zen-browser.packages.${pkgs.system}.twilight
    vesktop telegram-desktop signal-desktop qbittorrent protonvpn-gui

    # System utilities
    nautilus    (xfce.thunar.override {
      thunarPlugins = [ xfce.thunar-archive-plugin xfce.thunar-volman ];
    })
    numlockx  qpwgraph
    btop cpuid cpu-x hardinfo2 mission-center resources
    gnome-calculator warp hyperfine

    # Archive utils
    p7zip
    unrar
    xarchiver

    # Tools
    localsend

    # Misc
    sl cowsay fortune lolcat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  services.syncthing.enable = true;
  programs.home-manager.enable = true;
}
