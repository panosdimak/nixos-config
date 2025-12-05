{ pkgs, ... }:

{
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

      # LSP
      pkgs.vimPlugins.nvim-lspconfig

      # Completion
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-buffer
      pkgs.vimPlugins.cmp-path
      pkgs.vimPlugins.cmp_luasnip


      # Snippets
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.friendly-snippets

      # Telescope
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.telescope-fzf-native-nvim

      # File tree
      pkgs.vimPlugins.nvim-tree-lua

      # UI/UX
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.nvim-autopairs
      pkgs.vimPlugins.nvim-surround
      pkgs.vimPlugins.which-key-nvim

      # Colorscheme
      pkgs.vimPlugins.tokyonight-nvim
    ];

    extraPackages = with pkgs.tree-sitter-grammars; [
      tree-sitter-c
      tree-sitter-cpp
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
      vim.opt.termguicolors = true     -- Better colors
      vim.cmd("colorscheme tokyonight")

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

      -- File explorer
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    '';
  };
}