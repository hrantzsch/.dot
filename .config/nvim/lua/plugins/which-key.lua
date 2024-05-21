local function toggle_lsp()
  if next(vim.lsp.get_active_clients()) == nil then
    vim.cmd "LspStart"
  else
    vim.cmd "LspStop"
  end
end

local function toggle_wrap()
  vim.o.wrap = not vim.o.wrap
end

local function toggle_prose_mode()
  if vim.o.wrap or vim.o.spell then
    vim.o.wrap = false
    vim.o.spell = false
    print('Prose mode off')
  else
    vim.o.wrap = true
    vim.o.spell = true
    print('Prose mode on')
  end
end

local function word_under_cursor()
  vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
  vim.cmd('set hlsearch')   -- force highlight update
end

---@format disable-next
local normal_maps = {
  ["<cr>"]  = { word_under_cursor,                               "Search word under cursor"},
  ["<c-c>"] = { [["+yy]],                                        "Copy to system clipboard" },
  ["<c-]>"] = { "<cmd>lua vim.lsp.buf.definition()<cr>",         "Go to Definition" },
  ["<c-p>"] = { "<cmd>Telescope commands<cr>",                   "Commands" },

  ["[b"]    = { "<cmd>BufferLineCyclePrev<cr>",                  "Prev Buffer" },
  ["]b"]    = { "<cmd>BufferLineCycleNext<cr>",                  "Next Buffer" },
  ["[c"]    = { "<cmd>lua require('gitsigns').prev_hunk()<cr>",  "Prev Git Hunk" },
  ["]c"]    = { "<cmd>lua require('gitsigns').next_hunk()<cr>",  "Next Git Hunk" },
  ["[q"]    = { "<cmd>cprevious<cr>",                            "Prev Quickfix Entry" },
  ["]q"]    = { "<cmd>cnext<cr>",                                "Next Quickfix Entry" },

  ["<f12>"] = { "<cmd>10split | terminal f12 %<cr>",             "f12" },

  ["<leader>"] = {

    ["<leader>"] = { "<cmd>Telescope resume<cr>",  "Reopen Telescope" },
    b = { "<cmd>BufferLinePick<cr>",               "Pick Buffer" },
    B = { "<cmd>Telescope buffers<cr>",            "Choose Buffer (Telescope)" },
    d = { "<cmd>bp|bd #<cr>",                      "Close Buffer" },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>",     "Format" },
    j = { "<cmd>Telescope jumplist<cr>",           "Jumplist" },
    o = { "<cmd>Telescope find_files<cr>",         "Open File" },
    p = { toggle_prose_mode,                       "Toggle Prose Mode" },
    q = { "<cmd>cclose<cr>",                       "Close Quickfix" },
    w = { toggle_wrap,                             "Toggle Wrap" },
    y = { [[:let @+=expand("%:p")<cr>]],           "Yank file name" },

    c = { name = "Config",
      c = { "<cmd>Lazy<cr>",           "Lazy menu" },
      e = { "<cmd>edit $MYVIMRC<cr>",  "Open Config" },
      u = { "<cmd>Lazy update<cr>",    "Lazy update" },
    },

    g = { name = "Git",
      o = { "<cmd>Telescope git_status<cr>",    "Open Changed File" },

      b = { "<cmd>Gitsigns toggle_current_line_blame<cr>",             "Toggle line blame" },
      d = { "<cmd>Gitsigns diffthis<cr>",                              "Show Diff" },
      h = { "<cmd>Gitsigns toggle_linehl<cr>",                         "Toggle line highlighting" },
      H = { require("custom.blame-heat").GitBlameHeat,                 "Git blame heat" },
      j = { "<cmd>Gitsigns next_hunk<cr>",                             "Next Hunk" },
      k = { "<cmd>Gitsigns prev_hunk<cr>",                             "Prev Hunk" },
      l = { "<cmd>Gitsigns blame_line<cr>",                            "Blame" },
      L = { "<cmd>lua require('gitsigns').blame_line{full=true}<cr>",  "Full Blame" },
      p = { "<cmd>Gitsigns preview_hunk<cr>",                          "Preview Hunk" },
      R = { "<cmd>Gitsigns reset_buffer<cr>",                          "Reset Buffer" },
      r = { "<cmd>Gitsigns reset_hunk<cr>",                            "Reset Hunk" },
      S = { "<cmd>Gitsigns stage_buffer<cr>",                          "Stage Buffer" },
      s = { "<cmd>Gitsigns stage_hunk<cr>",                            "Stage Hunk" },
      u = { "<cmd>Gitsigns undo_stage_hunk<cr>",                       "Undo Stage Hunk" },
    },

    l = { name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>",            "Code Action" },
      d = { "<cmd>Telescope diagnostics<cr>",                    "Diagnostics" },
      q = { "<cmd>Telescope quickfix<cr>",                       "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>",                 "Rename" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",  "Workspace Symbols" },
      t = { toggle_lsp,                                          "Toggle LSP" },
      u = { "<cmd>Telescope lsp_references<cr>",                 "References" },
    },

    t = { name = "Telescope",
      a = { "<cmd>Telescope grep_string<cr>",   "Grep String" },
      b = { "<cmd>Telescope git_branches<cr>",  "Checkout Branch" },
      C = { "<cmd>Telescope git_bcommits<cr>",  "Checkout Commit (for current file)" },
      c = { "<cmd>Telescope git_commits<cr>",   "Checkout Commit" },
      g = { "<cmd>Telescope live_grep<cr>",     "Live Grep" },
    },

  },
  -- labels
  ["<leader>v"] = "Visual Multi",
}

---@format disable-next
local insert_maps = {
  ["<c-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>",  "Signature Help" },
  ["<c-v>"] = { "<esc>pa",                                    "Paste" },
}

---@format disable-next
local visual_maps = {
  ["<c-c>"] = { [["+y]], "Copy to system clipboard" },

  -- labels
  ["<leader>v"] = "Visual Multi",
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    require("which-key").register(normal_maps)
    require("which-key").register(insert_maps, { mode = "i" })
    require("which-key").register(visual_maps, { mode = "v" })
  end,
}
