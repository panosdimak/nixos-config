{
  pkgs,
  inputs,
  ...
}: {
  home.username = "panos";
  home.homeDirectory = "/home/panos";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Core utilities
    coreutils
    gnused
    gawk
    findutils
    bashInteractive
    curl
    wget
    zip
    unzip
    tree
    fastfetch
    jq

    # Editors / Writing
    obsidian
    onlyoffice-desktopeditors
    evince
    featherpad

    # Terminal / Shell
    ghostty
    kitty-themes
    starship
    lsd
    procs
    yazi
    ncdu
    duf
    dust

    # Clipboard / Screenshot / OCR
    wl-clipboard
    grim
    slurp
    grimblast
    charm-freeze
    tesseract

    # Media
    celluloid
    obs-studio
    gapless
    nomacs
    qimgv
    tidal-hifi

    # Internet
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    mullvad-browser
    brave
    telegram-desktop
    signal-desktop
    qbittorrent
    proton-vpn

    # Theming
    matugen

    # System utilities
    nautilus
    (thunar.override {
      thunarPlugins = [thunar-archive-plugin thunar-volman];
    })
    btop
    cpuid
    cpu-x
    hardinfo2
    mission-center
    resources
    gnome-calculator
    warp
    hyperfine
    waypaper
    wdisplays

    # Archive utils
    p7zip
    unrar
    file-roller

    # Tools
    localsend

    # Misc
    sl
    cowsay
    fortune
    lolcat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.vesktop.enable = true;

  services.syncthing.enable = true;

  services.kdeconnect = {
    enable = true;
    indicator = true; # Adds the system tray indicator
  };

  programs.home-manager.enable = true;

  xdg.desktopEntries."zen-twilight" = {
    name = "Zen Browser Twilight";
    exec = "zen-twilight %U";
    icon = "zen-browser";
    categories = ["Network" "WebBrowser"];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    terminal = false;
  };
}
