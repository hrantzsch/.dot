return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "auto",
    disable_background = true,
    dim_nc_background = true,
    -- rose (default) is too close to love, making changes look like deletions
    groups = {
      git_change = "iris",
      git_text = "gold",
    },
  },
  init = function()
    vim.cmd("colorscheme rose-pine")
  end
}
