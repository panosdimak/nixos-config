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
}