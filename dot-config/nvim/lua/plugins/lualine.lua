return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        component_separators = { left = ' ', right = ' ' }
      },
      sections = {
        lualine_a = { 'branch' },
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = { 'diagnostics' },
        lualine_x = { 'lsp_progress', 'filetype', 'encoding', 'fileformat', 'copilot', },
        lualine_y = { 'location' },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = {},
      },
    },
  },
  { 'arkav/lualine-lsp-progress' },
  { 'AndreM222/copilot-lualine' }
}
