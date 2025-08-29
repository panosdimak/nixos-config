{ config, pkgs, inputs, ... }:

{
  home.username = "potis";
  home.homeDirectory = "/home/potis";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # User applications and tools moved from system
  home.packages = with pkgs; [
    hello
    gcc
    gnumake
    coreutils
    gnused
    gawk
    findutils
    bashInteractive
    binutils
    git git-credential-manager curl wget unzip tree
    fastfetch
    obsidian
    neovim vscode
    ghostty starship
    wl-clipboard
    grim slurp tesseract
    mpv obs-studio
    discord telegram-desktop 
    spotify
    reaper
    numlockx
    sl cowsay fortune lolcat
    libreoffice
    onlyoffice-desktopeditors
    btop
    qbittorrent
    gnome-calculator 
    kdePackages.kcolorchooser 
    protonvpn-gui
    warp
    helvum   # optional GUI patchbay
    qjackctl # optional JACK control GUI
    ollama
    cpuid
    

    inputs.zen-browser.packages.${pkgs.system}.twilight
  ];

  programs.bash = {
    enable = true;
    initExtra = ''eval "$(starship init bash)"'';
    shellAliases = {
      vim         = "nvim";
      nixbuildflake  = "sudo nixos-rebuild switch --flake ~/nix-config#desktop";
      homeconfig  = "nvim ~/.config/home-manager/home.nix";
      homeswitch  = "home-manager switch";
    };
  };
  
  programs.ghostty = { 
    enable = true;
    settings = {
    theme = "xcodedark";
    font-family = "JetBrainsMonoNL Nerd Font";
    background-opacity = 0.8;
    background-blur = true;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$fill$cmake$cpp$nix_shell$jobs$cmd_duration$line_break$character";

      fill.symbol = " ";

      c = {
        style = "";
        format = "[$name $version ]($style)";
      };
    };
  };

  programs.git = {
    enable = true;
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "panosdimak";
    extraConfig.credential.credentialStore = "cache";
  };

  # Environment variables that are user-scoped (keep system-critical ones in configuration.nix)
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Syncthing as a user service (starts automatically on login)
  services.syncthing.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
