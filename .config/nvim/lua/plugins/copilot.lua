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
  -- { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
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
    }
    -- See Commands section for default commands if you want to lazy load on them
  },
}
