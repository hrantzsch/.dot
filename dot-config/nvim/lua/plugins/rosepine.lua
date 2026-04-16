return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "auto",
    disable_background = true,
    dim_nc_background = true,
  },
  init = function()
    vim.cmd("colorscheme rose-pine")
  end
}
