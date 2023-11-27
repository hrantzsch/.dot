return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      layout_config = { horizontal = { prompt_position = "top" } },
      layout_strategy = "flex",
      sorting_strategy = "ascending",
    },
  },
}
