return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    keys = {
      { "]n", function() require("custom.ts-move").next() end, desc = "TS next sibling node" },
      { "[n", function() require("custom.ts-move").prev() end, desc = "TS prev sibling node" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      -- move
      { "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev function start" },
      { "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start(    "@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next function start" },
      { "[F", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev function end" },
      { "]F", function() require("nvim-treesitter-textobjects.move").goto_next_end(    "@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next function end" },
      { "[a", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev parameter" },
      { "]a", function() require("nvim-treesitter-textobjects.move").goto_next_start(    "@parameter.inner", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next parameter" },
      -- swap
      { "<leader>a", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end, desc = "Swap next parameter" },
      { "<leader>A", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end, desc = "Swap previous parameter" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    keys = {
      { "<c-h>", "<cmd>lua require('treesitter-context').go_to_context()<cr>", desc = "Go to context" },
    },
    opts = { max_lines = 4, mode = 'topline', },
  },
}
