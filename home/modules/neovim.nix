{pkgs, ...}: let
  gccUnwrapped = pkgs.gcc.cc;
  gccVersion = gccUnwrapped.version;
  target = pkgs.stdenv.hostPlatform.config;
in {
  xdg.configFile."clangd/config.yaml".text = ''
    If:
      PathMatch: .*\.(cpp|cc|cxx|hpp|hxx|h)$
    CompileFlags:
      Add:
        - -std=c++23
        - -isystem
        - ${gccUnwrapped}/include/c++/${gccVersion}
        - -isystem
        - ${gccUnwrapped}/include/c++/${gccVersion}/${target}
        - -isystem
        - ${gccUnwrapped}/lib/gcc/${target}/${gccVersion}/include
        - -isystem
        - ${pkgs.glibc.dev}/include

    ---
    If:
      PathMatch: .*\.c$
    CompileFlags:
      Add:
        - -std=c17
        - -isystem
        - ${pkgs.glibc.dev}/include
        - -isystem
        - ${pkgs.liburing.dev}/include
  '';

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
        p.markdown_inline
        p.html
        p.latex
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
      pkgs.vimPlugins.plenary-nvim
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

      # Markdown preview
      pkgs.vimPlugins.markview-nvim
    ];

    initLua = ''
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
      require("markview").setup()
      vim.keymap.set('n', '<leader>mt', '<cmd>Markview Toggle<cr>', { desc = 'Markview toggle' })
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

      -- Helper: register an LSP server on specific filetypes
      local function start_server(filetypes, cmd, root_markers, extra)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = filetypes,
          callback = function()
            local config = vim.tbl_extend("force", {
              name = cmd[1],
              cmd = cmd,
              capabilities = capabilities,
              root_dir = vim.fs.root(0, root_markers or { ".git" }),
            }, extra or {})
            vim.lsp.start(config)
          end,
        })
      end

      -- lua-language-server
      start_server(
        { "lua" },
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
        { "c", "cpp" },
        { "clangd" },
        { ".git", "compile_commands.json" }
      )

      -- nixd
      start_server(
        { "nix" },
        { "nixd" },
        { ".git", "flake.nix", "default.nix" },
        {
          settings = {
            nixd = {
              nixpkgs = {
                expr = 'import <nixpkgs> { }'
              },
              formatting = {
                command = { "alejandra" }
              },
              options = {
                enable = true
              }
            }
          }
        }
      )

      -- bashls
      start_server(
        { "sh", "bash" },
        { "bash-language-server", "start" },
        { ".git" }
      )

      -- jsonls
      start_server(
        { "json", "jsonc" },
        { "vscode-json-language-server", "--stdio" },
        { ".git" }
      )

      -- yamlls
      start_server(
        { "yaml" },
        { "yaml-language-server", "--stdio" },
        { ".git" }
      )
      -- Completion
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Telescope
      require("telescope").setup({})
      require('telescope').load_extension('fzf')
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      -- File explorer
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Explorer toggle' })
    '';
  };
}
