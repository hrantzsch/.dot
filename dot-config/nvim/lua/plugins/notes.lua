return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>n", "<cmd>Note<cr>", desc = "Notes" },
  },
  init = function()
    local NOTES_DIR = vim.fn.expand(vim.g.notes_dir or "~/Notes/")
    if not NOTES_DIR:match("/$") then NOTES_DIR = NOTES_DIR .. "/" end

    local function complete_note(arg_lead)
      local files = vim.fn.glob(NOTES_DIR .. arg_lead .. "**/*.md", false, true)
      return vim.tbl_map(function(f)
        local rel = f:sub(#NOTES_DIR + 1)
        return rel:gsub("%.md$", "")
      end, files)
    end

    vim.api.nvim_create_user_command("Note", function(opts)
      local name = opts.args
      if name == "" then
        require("fzf-lua").files({ cwd = NOTES_DIR })
      elseif name:match("/$") then
        require("fzf-lua").files({ cwd = NOTES_DIR .. name })
      else
        vim.cmd("edit " .. NOTES_DIR .. name .. ".md")
      end
    end, {
      nargs = "?",
      complete = complete_note,
      desc = "Open a note by name",
    })
  end,
}
