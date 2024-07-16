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
  vim.cmd('set hlsearch') -- force highlight update
end

---@format disable-next
local normal_maps = {
  -- { "<c-]>", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
  { "<c-c>", '"+yy',                        desc = "Copy to system clipboard" },
  { "<c-p>", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<cr>", word_under_cursor,              desc = "Search word under cursor" },

  { "<f12>", "<cmd>10split | terminal f12 %<cr>", desc = "f12" },

  { "<leader><leader>", "<cmd>Telescope resume<cr>", desc = "Reopen Telescope" },
  { "<leader>B", "<cmd>Telescope buffers<cr>",       desc = "Choose Buffer (Telescope)" },
  { "<leader>b", "<cmd>BufferLinePick<cr>",          desc = "Pick Buffer" },

  { "<leader>c", group = "Config" },
  { "<leader>cc", "<cmd>Lazy<cr>",          desc = "Lazy menu" },
  { "<leader>ce", "<cmd>edit $MYVIMRC<cr>", desc = "Open Config" },
  { "<leader>cu", "<cmd>Lazy update<cr>",   desc = "Lazy update" },

  { "<leader>d", "<cmd>bp|bd #<cr>",                  desc = "Close Buffer" },
  { "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },

  { "<leader>g", group = "Git" },
  { "<leader>gL", "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", desc = "Full Blame" },
  { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>",                         desc = "Reset Buffer" },
  { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>",                         desc = "Stage Buffer" },
  { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>",            desc = "Toggle line blame" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",                             desc = "Show Diff" },
  { "<leader>gh", "<cmd>Gitsigns toggle_linehl<cr>",                        desc = "Toggle line highlighting" },
  { "<leader>gj", "<cmd>Gitsigns next_hunk<cr>",                            desc = "Next Hunk" },
  { "<leader>gk", "<cmd>Gitsigns prev_hunk<cr>",                            desc = "Prev Hunk" },
  { "<leader>gl", "<cmd>Gitsigns blame_line<cr>",                           desc = "Blame" },
  { "<leader>go", "<cmd>Telescope git_status<cr>",                          desc = "Open Changed File" },
  { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>",                         desc = "Preview Hunk" },
  { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",                           desc = "Reset Hunk" },
  { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>",                           desc = "Stage Hunk" },
  { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>",                      desc = "Undo Stage Hunk" },

  { "<leader>j", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },

  { "<leader>l", group = "LSP" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",           desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnostics" },
  { "<leader>lq", "<cmd>Telescope quickfix<cr>",                      desc = "Quickfix" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                desc = "Rename" },
  { "<leader>lt", toggle_lsp,                                         desc = "Toggle LSP" },
  { "<leader>lu", "<cmd>Telescope lsp_references<cr>",                desc = "References" },

  { "<leader>o", "<cmd>Telescope find_files<cr>", desc = "Open File" },
  { "<leader>p", toggle_prose_mode,               desc = "Toggle Prose Mode" },
  { "<leader>q", "<cmd>cclose<cr>",               desc = "Close Quickfix" },

  { "<leader>t", group = "Telescope" },
  { "<leader>tC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout Commit (for current file)" },
  { "<leader>ta", "<cmd>Telescope grep_string<cr>",  desc = "Grep String" },
  { "<leader>tb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
  { "<leader>tc", "<cmd>Telescope git_commits<cr>",  desc = "Checkout Commit" },
  { "<leader>tg", "<cmd>Telescope live_grep<cr>",    desc = "Live Grep" },

  { "<leader>v",                              desc = "Visual Multi" },
  { "<leader>w", toggle_wrap,                 desc = "Toggle Wrap" },
  { "<leader>y", ':let @+=expand("%:p")<cr>', desc = "Yank file name" },

  { "[b", "<cmd>BufferLineCyclePrev<cr>",                 desc = "Prev Buffer" },
  { "[c", "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Prev Git Hunk" },
  { "[q", "<cmd>cprevious<cr>",                           desc = "Prev Quickfix Entry" },
  { "]b", "<cmd>BufferLineCycleNext<cr>",                 desc = "Next Buffer" },
  { "]c", "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Git Hunk" },
  { "]q", "<cmd>cnext<cr>",                               desc = "Next Quickfix Entry" },
}

---@format disable-next
local visual_maps = {
  { "<c-c>", '"+y', desc = "Copy to system clipboard", mode = "v" },
  { "<leader>v",    desc = "Visual Multi", mode = "v" },
}

return {
  "folke/which-key.nvim",
  dependencies = {'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons'},
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    require("which-key").add(normal_maps)
    require("which-key").add(visual_maps)
  end,
}
