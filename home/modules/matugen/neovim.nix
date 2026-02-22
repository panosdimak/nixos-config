{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/nvim-colors.lua".text = ''
      require('mini.base16').setup({
        palette = {
          base00 = '{{colors.surface.default.hex}}',
          base01 = '{{colors.surface_container.default.hex}}',
          base02 = '{{colors.surface_container_high.default.hex}}',
          base03 = '{{colors.outline.default.hex}}',
          base04 = '{{colors.on_surface_variant.default.hex}}',
          base05 = '{{colors.on_surface.default.hex}}',
          base06 = '{{colors.on_primary_container.default.hex}}',
          base07 = '{{colors.surface_bright.default.hex}}',
          base08 = '{{colors.error.default.hex}}',
          base09 = '{{colors.on_error_container.default.hex}}',
          base0A = '{{colors.secondary.default.hex}}',
          base0B = '{{colors.tertiary.default.hex}}',
          base0C = '{{colors.on_secondary_container.default.hex}}',
          base0D = '{{colors.primary.default.hex}}',
          base0E = '{{colors.tertiary_fixed_dim.default.hex}}',
          base0F = '{{colors.on_tertiary_container.default.hex}}',
        }
      })
      vim.api.nvim_set_hl(0, 'Visual', { bg = '{{colors.primary.default.hex}}', fg = '{{colors.on_primary.default.hex}}' })
      vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
      vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
      vim.cmd.highlight({ "SignColumn", "guibg=NONE", "ctermbg=NONE" })
    '';
  };

  fallback = createIfMissing "${configHome}/nvim/matugen-colors.lua" ''
require('mini.base16').setup({
  palette = {
    base00 = '#${colors.surface}', base01 = '#${colors.surface_container}',
    base02 = '#${colors.surface_container_high}', base03 = '#${colors.outline}',
    base04 = '#${colors.on_surface_variant}', base05 = '#${colors.on_surface}',
    base06 = '#b4befe', base07 = '#${colors.surface_bright}',
    base08 = '#${colors.error}', base09 = '#eba0ac',
    base0A = '#${colors.secondary}', base0B = '#${colors.tertiary}',
    base0C = '#${colors.secondary}', base0D = '#${colors.primary}',
    base0E = '#${colors.tertiary_fixed_dim}', base0F = '#f5e0dc',
  }
})
vim.api.nvim_set_hl(0, 'Visual', { bg = '#${colors.primary}', fg = '#${colors.on_primary}' })
vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "SignColumn", "guibg=NONE", "ctermbg=NONE" })'';
}
