{ pkgs, inputs, ... }:

{
  imports = [
    ./plasma.nix
  ];

  home.username = "panos";
  home.homeDirectory = "/home/panos";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Development tools
    gcc gnumake coreutils gnused gawk findutils bashInteractive binutils
    git git-credential-manager curl wget unzip tree fastfetch
    
    # Editors / IDE / Writing
    obsidian vscode onlyoffice-desktopeditors

    # Terminal / Shell
    ghostty starship ripgrep fzf bat lsd procs nnn
    ncdu

    # Clipboard / Screenshot / OCR
    wl-clipboard grim slurp tesseract

    # Media
    mpv obs-studio spotify gapless
   
    # Emulation utils
    wineWow64Packages.staging winetricks

    # Internet
    inputs.zen-browser.packages.${pkgs.system}.twilight
    vesktop telegram-desktop qbittorrent protonvpn-gui

    # ML
    ollama

    # System utilities
    nautilus numlockx  qpwgraph  
    btop cpuid cpu-x hardinfo2 mission-center resources
    kdePackages.kalk kdePackages.kcolorchooser warp

    # Misc
    sl cowsay fortune lolcat
  ];
  
  programs.plasma.enable = true;

  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = [
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.comment-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.gitsigns-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.vim-sensible
    ];

    extraPackages = with pkgs.tree-sitter-grammars; [
      tree-sitter-nix
      tree-sitter-lua
      tree-sitter-bash
      tree-sitter-json
      tree-sitter-yaml
      tree-sitter-toml
      tree-sitter-markdown
    ];

    extraLuaConfig = ''
      -- Options
      vim.opt.number = true            -- Show line numbers
      vim.opt.relativenumber = false    -- Relative numbers for navigation
      vim.opt.expandtab = true         -- Use spaces instead of tabs
      vim.opt.shiftwidth = 2           -- Indent width
      vim.opt.tabstop = 2              -- Tab width
      vim.opt.clipboard = "unnamedplus" -- Use system clipboard
      vim.opt.wrap = false             -- Don't wrap long lines
      vim.opt.mouse = "a"              -- Enable mouse support
      vim.opt.hidden = true            -- Allow switching buffers without saving
      vim.opt.termguicolors = false     -- Better colors

      -- Plugins
      require("gitsigns").setup()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        }
      })
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
      })
    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''eval "$(starship init bash)"'';
    shellAliases = {
      nixbuildflake  = "sudo nixos-rebuild switch --flake ~/nixos-config#ryzen-desktop";
      vim = "nvim";
      ls = "lsd";
      tree = "lsd --tree";
    };
  };
  
  programs.ghostty = { 
    enable = true;
    settings = {
    background-opacity = 0.8;
    background-blur = true;
    cursor-style = "bar";
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
