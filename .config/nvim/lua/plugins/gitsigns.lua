return {
  'lewis6991/gitsigns.nvim',
  opts = { current_line_blame_opts = { delay = 50 }, },
  keys = {
    { "<leader>gb", "<cmd>Gitsigns blame<cr>",                                desc = "Blame" },
    { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",                             desc = "Show Diff" },
    { "<leader>gh", "<cmd>Gitsigns toggle_linehl<cr>",                        desc = "Toggle line highlighting" },
    { "<leader>gl", "<cmd>Gitsigns blame_line<cr>",                           desc = "Blame" },
    { "<leader>gL", "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", desc = "Full Blame" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>",                         desc = "Preview Hunk" },
    { "<leader>gq", "<cmd>Gitsigns setqflist<cr>",                            desc = "Fill Quickfix" },
    { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>",                         desc = "Reset Buffer" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",                           desc = "Reset Hunk" },
    { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>",                         desc = "Stage Buffer" },
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>",                           desc = "Stage Hunk" },
    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>",                      desc = "Undo Stage Hunk" },
    { "[c",         "<cmd>Gitsigns prev_hunk<cr>",                            desc = "Prev Hunk" },
    { "]c",         "<cmd>Gitsigns next_hunk<cr>",                            desc = "Next Hunk" },
  }
}
