vim.o.completeopt = "menu,menuone,popup,fuzzy"

vim.o.foldenable = true
vim.o.foldlevel = 99      -- start editing with all folds opened
vim.o.foldmethod = "expr" -- use tree-sitter for folding method
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.o.hidden = true

vim.o.scrolloff = 3
vim.o.wrap = false
-- vim.o.linebreak = true

vim.o.mouse = "a"

vim.o.termguicolors = true  -- enable rgb colors
vim.o.background = [[dark]]
vim.o.winborder = [[single]]

vim.o.cursorline = true

vim.o.number = true         -- enable line number
vim.o.relativenumber = true -- and relative line number

vim.o.signcolumn = "yes"    -- always show sign column

vim.o.pumheight = 10        -- max height of completion menu

vim.o.list = true           -- use special characters to represent things like tabs or trailing spaces
vim.opt.listchars = {       -- show tabs and trailing spaces
    tab = "▏ ",
    trail = "·",
    extends = "»",
    precedes = "«",
}

vim.opt.diffopt:append("linematch:60") -- second stage diff to align lines

vim.o.confirm = true     -- show dialog for unsaved file(s) before quit
vim.o.updatetime = 200   -- save swap file with 200ms debouncing

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.smartindent = true
vim.o.shiftround = true
vim.o.shiftwidth = 0
vim.o.tabstop = 2
vim.o.expandtab = true

vim.o.undofile = true

vim.o.spelllang = "en_us,de"

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")
