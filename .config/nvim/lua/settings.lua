-- general
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.timeoutlen = 500 -- this also controls which-key
vim.o.foldenable = false -- no auto-folding
vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.undofile = true

vim.o.linebreak = true

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.inccommand = "nosplit"

-- trailing spaces
vim.o.list = true
vim.o.listchars = "tab:»·,trail:·" -- show tabs and trailing spaces
vim.cmd "autocmd BufWritePre * %s/\\s\\+$//e" -- remove trailing tabs and spaces

vim.o.joinspaces = false -- insert only one space after '.' when joining lines

-- indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.expandtab = true

-- disable unused provder warnings in :checkhealth
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- appearence
vim.o.termguicolors = true

vim.wo.number = true
vim.o.relativenumber = true

vim.wo.signcolumn = "yes"

vim.cmd("autocmd TextYankPost * lua vim.highlight.on_yank {timeout = 250}")
