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
  keys = {
    { "<c-p>", "<cmd>Telescope commands<cr>",          desc = "Commands" },
    { "<leader><leader>", "<cmd>Telescope resume<cr>", desc = "Reopen Telescope" },
    { "<leader>B", "<cmd>Telescope buffers<cr>",       desc = "Choose Buffer (Telescope)" },
    { "<leader>j", "<cmd>Telescope jumplist<cr>",      desc = "Jumplist" },
    { "<leader>o", "<cmd>Telescope find_files<cr>",    desc = "Open File" },
    { "<leader>p", "<cmd>Telescope live_grep<cr>",     desc = "Live Grep" },
    { "<leader>r", "<cmd>Telescope grep_string<cr>",   desc = "Grep String" },
    -- git
    { "<leader>go", "<cmd>Telescope git_status<cr>",   desc = "Open Changed File" },
    { "<leader>gc", "<cmd>Telescope git_bcommits<cr>", desc = "Browse File Commits" },
  },
}
