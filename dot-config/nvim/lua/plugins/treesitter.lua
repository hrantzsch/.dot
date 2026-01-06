return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    depenencies = { "nvim-treesitter/nvim-treesitter" },
    -- TODO: map require("treesitter-context").go_to_context()
    opts = { max_lines = 4, mode = 'topline', },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   -- TODO: setup custom text objects
  --   depenencies = { "nvim-treesitter/nvim-treesitter" },
  -- },
}
