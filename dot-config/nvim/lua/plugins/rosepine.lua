return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "auto",
    -- dark_variant = "moon",
    disable_background = false,
    dim_nc_background = true,
  },
  init = function()
    vim.cmd("colorscheme rose-pine")
    -- local function hi(highlight, guifg, guibg, gui)
    --   guifg = guifg or "NONE"
    --   guibg = guibg or "NONE"
    --   gui = gui or "NONE"
    --   vim.cmd(string.format("hi %s guifg=%s guibg=%s gui=%s", highlight, guifg, guibg, gui))
    -- end
    --
    -- local palette = require("rose-pine.palette")
    -- local blend = function(fg, alpha)
    --   return require("rose-pine.util").blend(fg, palette.base, alpha)
    -- end
    -- hi("Search", palette.base, blend(palette.love, 0.8))
    -- hi("IncSearch", palette.love, palette.base, "bold")
    -- hi("TreesitterContext", nil, blend(palette.rose, 0.1))
    --
    -- Hardcoding the above...
    vim.cmd([[highlight Search                     guifg=#191724 guibg=#c15d7c]])
    vim.cmd([[highlight IncSearch         gui=bold guifg=#eb6f92 guibg=#191724]])
    vim.cmd([[highlight TreesitterContext                        guibg=#2e2833]])
  end
}
