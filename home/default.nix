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

  # The zen-twilight.desktop file declares Icon=zen-browser, but no such file
  # exists in the active icon themes. Quickshell-overview's icon lookup goes
  # strictly by that name (no class-name fallback like DMS), so it renders the
  # missing-icon rectangle. Symlink Fluent's zen-browser.svg into hicolor so
  # the name resolves for every consumer.
  home.file.".local/share/icons/hicolor/scalable/apps/zen-browser.svg".source = "${pkgs.fluent-icon-theme}/share/icons/Fluent-dark/scalable/apps/zen-browser.svg";
}
