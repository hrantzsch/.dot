local function toggle_lsp()
  local clients = vim.lsp.get_clients()
  if #clients > 0 then
    vim.lsp.stop_client(clients)
    print("LSP stopped")
  else
    vim.cmd("edit") -- reload buffer to trigger LSP attach
    print("LSP started")
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
  { "<leader>g",  group = "Git" },
  { "<leader>i",  group = "Copilot" },
  { "<leader>v",  group = "Visual Multi" },

  { "<c-c>", '"+yy',                        desc = "Copy to system clipboard" },
  { "<cr>", word_under_cursor,              desc = "Search word under cursor" },

  { "<leader>d", "<cmd>bp|bd #<cr>",        desc = "Close Buffer" },
  { "<leader>q", "<cmd>cclose<cr>",         desc = "Close Quickfix" },

  { "<f12>", "<cmd>10split | terminal f12 %<cr>", desc = "f12" },

  { "<leader>b", "<cmd>BufferLinePick<cr>",       desc = "Pick Buffer" },

  { "<leader>c", group = "Config" },
  { "<leader>cc", "<cmd>Lazy<cr>",          desc = "Lazy menu" },
  { "<leader>ce", "<cmd>edit $MYVIMRC<cr>", desc = "Open Config" },
  { "<leader>cu", "<cmd>Lazy update<cr>",   desc = "Lazy update" },

  { "<leader>l", group = "LSP" },
  { "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
  { "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<cr>",            desc = "Workspace Symbols" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",           desc = "Code Action" },
  { "<leader>ld", "<cmd>FzfLua diagnostics_workspace<cr>",            desc = "Diagnostics" },
  { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>",         desc = "Line Diagnostics" },
  { "<leader>lq", "<cmd>FzfLua quickfix<cr>",                         desc = "Quickfix" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                desc = "Rename" },
  { "<leader>lt", toggle_lsp,                                         desc = "Toggle LSP" },
  { "<leader>lu", "<cmd>FzfLua lsp_references<cr>",                   desc = "References" },

  { "<leader>p", toggle_prose_mode,               desc = "Toggle Prose Mode" },

  { "<leader>w", toggle_wrap,                 desc = "Toggle Wrap" },
  { "<leader>y", ':let @+=expand("%:p")<cr>', desc = "Yank file name" },

  { "[b", "<cmd>BufferLineCyclePrev<cr>",                 desc = "Prev Buffer" },
  { "[q", "<cmd>cprevious<cr>",                           desc = "Prev Quickfix Entry" },
  { "]b", "<cmd>BufferLineCycleNext<cr>",                 desc = "Next Buffer" },
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
