{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.nix
        p.lua
        p.bash
        p.json
        p.yaml
        p.toml
        p.markdown
      ]))
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

      # Colorscheme (mini.base16, themed by matugen)
      pkgs.vimPlugins.mini-nvim
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

      -- Load matugen-generated base16 colors
      local matugen_colors = vim.fn.stdpath("config") .. "/matugen-colors.lua"
      pcall(dofile, matugen_colors)

      -- Reload colors on SIGUSR1 (triggered by wallpaper-theme.sh)
      vim.api.nvim_create_autocmd("Signal", {
        pattern = "SIGUSR1",
        callback = function()
          pcall(dofile, matugen_colors)
        end,
      })

      -- Plugins
      require("gitsigns").setup()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        }
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Helper function to start an LSP server correctly
      local function start_server(cmd, root_markers, extra)
        local config = vim.tbl_extend("force", {
          cmd = cmd,
          capabilities = capabilities,
          root_dir = vim.fs.root(0, root_markers or { ".git" }),
        }, extra or {})

        vim.lsp.start(config)
      end

      -- lua-language-server
      start_server(
        { "lua-language-server" },
        { ".git", "lua" },
        {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" }},
            }
          }
        }
      )

      -- clangd
      start_server(
        { "clangd" },
        { ".git", "compile_commands.json" }
      )

      -- nixd
      start_server(
        { "nixd" },
        { ".git", "flake.nix", "default.nix" },
        {
          settings = {
            nixd = {
              nixpkgs = {
                expr = 'import <nixpkgs> { }'
              },
              formatting = {
                command = { "alejandra" }  -- or nixpkgs-fmt, treefmt, etc
              },
              options = {
                -- allow evaluation of flake outputs
                enable = true
              }
            }
          }
        }
      )

      -- bashls
      start_server(
        { "bash-language-server", "start" },
        { ".git" }
      )

      -- jsonls
      start_server(
        { "vscode-json-language-server", "--stdio" },
        { ".git" }
      )

      -- yamlls
      start_server(
        { "yaml-language-server", "--stdio" },
        { ".git" }
      )
      -- Telescope
      require("telescope").setup({})
      require('telescope').load_extension('fzf')

      -- File explorer
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    '';
  };
}
