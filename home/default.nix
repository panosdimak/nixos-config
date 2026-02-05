{ pkgs, inputs, ... }:
{

  home.username = "panos";
  home.homeDirectory = "/home/panos";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Core utilities
    coreutils gnused gawk findutils bashInteractive
    curl wget zip unzip tree fastfetch jq

    # Editors / Writing
    obsidian onlyoffice-desktopeditors evince xfce.mousepad

    # Terminal / Shell
    ghostty kitty kitty-themes starship lsd procs nnn
    ncdu duf dust

    # Clipboard / Screenshot / OCR
    wl-clipboard grim slurp grimblast charm-freeze tesseract

    # Media
    mpv haruna obs-studio gapless loupe tidal-hifi

    # Internet
    inputs.zen-browser.packages.${pkgs.system}.twilight
    vesktop telegram-desktop signal-desktop qbittorrent protonvpn-gui

    # Theming
    matugen

    # System utilities
    kdePackages.dolphin
    (xfce.thunar.override {
      thunarPlugins = [ xfce.thunar-archive-plugin xfce.thunar-volman ];
    })
    btop cpuid cpu-x hardinfo2 mission-center resources
    gnome-calculator warp hyperfine waypaper wdisplays

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

  programs.vesktop.enable = true;

  services.syncthing.enable = true;

  services.kdeconnect = {
    enable = true;
    indicator = true;  # Adds the system tray indicator
  };

  programs.home-manager.enable = true;
}
