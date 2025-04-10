return {
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
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>ic", "<cmd>CopilotChatToggle<cr>",  desc = "Toggle Chat" },
      { "<leader>ie", "<cmd>CopilotChatExplain<cr>", desc = "Explain" },
      { "<leader>ir", "<cmd>CopilotChatReview<cr>",  desc = "Review" },
      { "<leader>ic", ":'<,'>CopilotChat<cr>", mode = "v", desc = "Open Copilot Chat with selection" },
    }
    -- See Commands section for default commands if you want to lazy load on them
  },
}
