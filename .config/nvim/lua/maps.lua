local function map(key, cmd, mode, opts)
  mode = mode or "n"
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, key, cmd, opts)
end

local nmap = map
local function vmap(key, cmd) map(key, cmd, "v") end
local function tmap(key, cmd) map(key, cmd, "t") end
local function imap(key, cmd) map(key, cmd, "i") end

-- set <leader>
vim.api.nvim_set_keymap('n', '<Space>', '', {})
vim.g.mapleader = ' '

nmap('<C-l>', ':nohlsearch<cr>')

-- emulate 'modern' ctrl-c in normal and visual
nmap('<C-c>', '"+yy')
vmap('<C-c>', '"+y')
-- paste in insert mode
imap('<C-v>', '<Esc>pa')

-- clear line
nmap('X', '0d$')

-- visual selection to search
vmap('//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>')

-- navigation
nmap('<A-h>', '<C-w>h')
nmap('<A-j>', '<C-w>j')
nmap('<A-k>', '<C-w>k')
nmap('<A-l>', '<C-w>l')
nmap('<A-S-h>', '<C-w>H')
nmap('<A-S-j>', '<C-w>J')
nmap('<A-S-k>', '<C-w>K')
nmap('<A-S-l>', '<C-w>L')
-- terminal: escape and move
tmap('<C-e>', '<C-\\><C-n>:bn<CR>')
tmap('<C-q>', '<C-\\><C-n>:bN<CR>')
tmap('<A-h>', '<C-\\><C-n><C-w>h')
tmap('<A-j>', '<C-\\><C-n><C-w>j')
tmap('<A-k>', '<C-\\><C-n><C-w>k')
tmap('<A-l>', '<C-\\><C-n><C-w>l')

-- navigate buffers
nmap('<A-n>', ':bn<CR>')
nmap('<A-p>', ':bN<CR>')

nmap('<A-b>', '<C-^>')


local function toggle_lsp()
  if next(vim.lsp.get_active_clients()) == nil then
    vim.cmd "LspStart"
  else
    vim.cmd "LspStop"
  end
end

local prose_enabled = false;
local function prose_mode()
  if not prose_enabled then
    vim.o.wrap = true
    vim.o.spell = true
    print('Prose mode enabled')
  else
    vim.o.wrap = false
    vim.o.spell = false
    print('Prose mode disabled')
  end
  prose_enabled = not prose_enabled
end


local wk_mappings = {
  ["<leader>"] = {
    c = {
      name = "Config",
      c = {"<cmd>Telescope colorscheme<cr>",                          "Colorscheme"},
      e = {"<cmd>edit $MYVIMRC<cr>",                                  "Open Config"},
      u = {"<cmd>PackerUpdate<cr>",                                   "Run PackerUpdate"},
    },

     g = {
      name = "Git",
      b = {"<cmd>Telescope git_branches<cr>",                         "Checkout Branch"},
      C = {"<cmd>Telescope git_bcommits<cr>",                         "Checkout Commit(for current file)"},
      c = {"<cmd>Telescope git_commits<cr>",                          "Checkout Commit"},
      j = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>",             "Next Hunk"},
      k = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",             "Prev Hunk"},
      L = {"<cmd>lua require'gitsigns'.blame_line{full=true}<CR>",    "Full Blame"},
      l = {"<cmd>lua require 'gitsigns'.blame_line()<cr>",            "Blame"},
      o = {"<cmd>Telescope git_status<cr>",                           "Open Changed File"},
      p = {"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",          "Preview Hunk"},
      R = {"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",          "Reset Buffer"},
      r = {"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",            "Reset Hunk"},
      S = {"<cmd>lua require 'gitsigns'.stage_buffer()<cr>",          "Stage Buffer"},
      s = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",            "Stage Hunk"},
      u = {"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",       "Undo Stage Hunk"},
    },

    l = {
      name = "LSP",
      a = {"<cmd>lua vim.lsp.buf.code_action()<cr>",                  "Code Action"},
      A = {"<cmd>lua vim.lsp.buf.range_code_action()<cr>",            "Range Action"},
      d = {"<cmd>Telescope lsp_document_diagnostics<cr>",             "Document Diagnostics" },
      D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>",            "Workspace Diagnostics" },
      f = {"<cmd>lua vim.lsp.buf.formatting()<cr>",                   "Format"},
      i = {"<cmd>LspInfo<cr>",                                        "Info"},
      L = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Line Diagnostics"},
      q = {"<cmd>Telescope quickfix<cr>",                             "Quickfix"},
      r = {"<cmd>lua vim.lsp.buf.rename()<cr>",                       "Rename"},
      S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",        "Workspace Symbols"},
      s = {"<cmd>Telescope lsp_document_symbols<cr>",                 "Document Symbols"},
      t = {toggle_lsp,                                                "Toggle LSP"},
      u = {"<cmd>Telescope lsp_references<cr>",                       "References"},
      x = {"<cmd>cclose<cr>",                                         "Close Quickfix"},
    },

    t = {
      name = "Telescope",
      g = {"<cmd>Telescope live_grep<cr>",                            "Live Grep"},
      a = {"<cmd>Telescope grep_string<cr>",                          "Grep String"},
      -- h = {"<cmd>TSToggleAll highlight<cr>",                          "Toggle Highlight"},
      -- i = {"<cmd>TSToggleAll indent<cr>",                             "Toggle Indent"},
    },

    ["<leader>"] = {"<cmd>Telescope buffers<cr>",                     "Open Buffer"},
    o            = {"<cmd>Telescope find_files<cr>",                  "Open File"},
    d            = {"<cmd>bp|bd #<cr>",                               "Close Buffer"},
    p            = {prose_mode,                                       "Toggle Prose Mode"},
  },

  -- shortcuts
  ["[c"]    = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",         "Prev Git Hunk"},
  ["]c"]    = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>",         "Next Git Hunk"},
  ["<c-k>"] = {"<cmd>lua vim.lsp.buf.hover()<cr>",                    "Hover Doc"},
  ["<c-]>"] = {"<cmd>lua vim.lsp.buf.definition()<cr>",               "Go to Definition"},
  ["[d"]    = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",         "Prev Diagnostic"},
  ["]d"]    = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",         "Next Diagnostic"},
}

local opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

require'which-key'.register(wk_mappings, opts)
