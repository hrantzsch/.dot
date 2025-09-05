vim.o.mouse = "a"
vim.o.wrap = true

vim.o.termguicolors = true -- enable rgb colors
vim.o.background = [[dark]]
vim.o.winborder = [[single]]

vim.o.updatetime = 200 -- save swap file with 200ms debouncing
vim.o.spelllang = "en_us,de"
vim.o.undofile = false

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    {
      "zbirenbaum/copilot.lua",
      event = "VeryLazy",
      config = function()
        require("copilot").setup({
          suggestion = {
            auto_trigger = true,
            hide_during_completion = false,
            debounce = 50,
            keymap = {
              accept = "<tab>",
              -- accept_word = "<c-m>",
              next = "<c-.>",
              prev = "<c-,>",
            },
          },
          filetypes = {
            text = false,
            [""] = false,
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
          },
        })
      end,
    },
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      event = "VeryLazy",
      branch = "main",
      build = "make tiktoken",
      dependencies = {
        { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
        { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
      },
      opts = {
        debug = false,
      },
      keys = {
        { "<leader>ic", "<cmd>CopilotChatToggle<cr>",  desc = "Toggle Chat" },
        { "<leader>ie", "<cmd>CopilotChatExplain<cr>", desc = "Explain" },
        { "<leader>ir", "<cmd>CopilotChatReview<cr>",  desc = "Review" },
        { "<leader>ic", ":'<,'>CopilotChat<cr>",       mode = "v",          desc = "Open Copilot Chat with selection" },
      }
      -- See Commands section for default commands if you want to lazy load on them
    },
  },
  {
    install = { missing = true, colorscheme = { "lunaperche" }, },
    checker = { enabled = true },
  }
)

local chat = require("CopilotChat")
chat.open({window = { layout = "replace"}, auto_insert_mode = true })
