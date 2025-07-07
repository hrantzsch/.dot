return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "c", "cpp", "haskell", "html", "javascript", "lua", "python", "rust",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    depenencies = { "nvim-treesitter/nvim-treesitter" },
    -- TODO: map require("treesitter-context").go_to_context()
    opts = { max_lines = 4, mode = 'topline', },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- TODO: setup custom text objects
    depenencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
