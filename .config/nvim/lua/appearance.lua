vim.o.termguicolors = true

vim.wo.number = true
vim.wo.signcolumn = "yes"

vim.cmd("autocmd TextYankPost * lua vim.highlight.on_yank {timeout = 250}")

vim.g["everforest_enable_italic"] = 1
-- vim.g["everforest_background"] = 'soft'
vim.g["everforest_better_performance"] = 1
vim.cmd("colorscheme everforest")

vim.cmd("hi Comment cterm=italic")
