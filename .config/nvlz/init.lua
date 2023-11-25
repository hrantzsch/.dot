vim.api.nvim_set_keymap('n', '<Space>', '', {})
vim.g.mapleader = " "

-- general
vim.o.hidden = true
vim.o.mouse = "a"
-- vim.o.foldenable = false -- no auto-folding
vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.undofile = true

vim.o.linebreak = true

vim.o.completeopt = "menuone,noselect" -- disable scratch preview

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- trailing spaces
vim.o.list = true
vim.o.listchars = "tab:»·,trail:·"            -- show tabs and trailing spaces
vim.cmd "autocmd BufWritePre * %s/\\s\\+$//e" -- remove trailing tabs and spaces

vim.o.joinspaces = false                      -- insert only one space after '.' when joining lines

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
vim.o.background = [[dark]]

vim.o.number = true
vim.o.relativenumber = true

vim.cmd([[autocmd TextYankPost * lua vim.highlight.on_yank {timeout = 250}]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("plugins.rosepine"),
    require("plugins.lsp"),
    require("plugins.telescope"),
    require("plugins.treesitter"),
    require("plugins.lualine"),
    require("plugins.which-key"),
    require("plugins.bufferline"),
    require("plugins.gitsigns"),
    require("plugins.illuminate"),
    require("plugins.visual-multi"),

    { 'numToStr/Comment.nvim', config = true },

    { "tpope/vim-repeat" },
    { "tpope/vim-surround" },
  },
  {
    install = {
      missing = true,
      colorscheme = { "rose-pine" },
    },
  })
