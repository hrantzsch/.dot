---@format disable-next
return {
  "dlyongemallo/diffview-plus.nvim",
  version = "*",
  main = "diffview",
  cmd = { "DiffviewOpen", "DiffviewToggle", "DiffviewFileHistory", "DiffviewDiffFiles", "DiffviewLog" },
  keys = {
    { "<leader>gv", "<cmd>DiffviewToggle<cr>",           desc = "Diffview Toggle" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>",    desc = "File History" },
    { "<leader>gF", "<cmd>DiffviewFileHistory<cr>",      desc = "Repo History" },
    { "<leader>gf", ":DiffviewFileHistory<cr>",          desc = "History of Selection", mode = "v" },
    { "<leader>g^", "<cmd>DiffviewOpen HEAD^<cr>",       desc = "Diff vs HEAD^" },
  },
  opts = {
    enhanced_diff_hl = true,      -- distinguish changed text from changed lines
    hide_merge_artifacts = true,  -- keep *.orig / *.BACKUP.* out of the file panel
    clean_up_buffers = true,      -- don't leave diff buffers in the bufferline afterwards
    auto_close_on_empty = true,   -- staging the last file ends the review

    view = {
      default = {
        winbar_info = true, -- label which rev each window shows
        layout = "diff1_inline",
      },
      file_history = { layout = "diff1_inline" },
      merge_tool = { layout = "diff3_mixed" },
    },

    file_panel = {
      show_branch_name = true,
    },
  },
}
