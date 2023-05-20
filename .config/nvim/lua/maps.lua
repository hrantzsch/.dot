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

imap('<c-u>', '<Plug>luasnip-expand-or-jump')

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

local function prose_mode()
  if vim.o.wrap or vim.o.spell then
    vim.o.wrap = false
    vim.o.spell = false
    print('Prose mode disabled')
  else
    vim.o.wrap = true
    vim.o.spell = true
    print('Prose mode enabled')
  end
end

---@format disable-next
local wk_nmaps = {
  ["<leader>"] = {
    c = {
      name = "Config",
      c = {"<cmd>Telescope colorscheme<cr>",                          "Colorscheme"},
      e = {"<cmd>edit $MYVIMRC<cr>",                                  "Open Config"},
      u = {"<cmd>PackerUpdate<cr>",                                   "Run PackerUpdate"},
    },

    g = {
      name = "Git",
      b = { "<cmd>Telescope git_branches<cr>",                        "Checkout Branch" },
      C = { "<cmd>Telescope git_bcommits<cr>",                        "Checkout Commit(for current file)" },
      c = { "<cmd>Telescope git_commits<cr>",                         "Checkout Commit" },
      o = { "<cmd>Telescope git_status<cr>",                          "Open Changed File" },

      k = { "<cmd>Gitsigns prev_hunk<cr>",                            "Prev Hunk" },
      j = { "<cmd>Gitsigns next_hunk<cr>",                            "Next Hunk" },
      l = { "<cmd>Gitsigns blame_line<cr>",                           "Blame" },
      L = { "<cmd>lua require 'gitsigns'.blame_line{full=true}<cr>",  "Full Blame" },
      p = { "<cmd>Gitsigns preview_hunk<cr>",                         "Preview Hunk" },
      r = { "<cmd>Gitsigns reset_hunk<cr>",                           "Reset Hunk" },
      R = { "<cmd>Gitsigns reset_buffer<cr>",                         "Reset Buffer" },
      s = { "<cmd>Gitsigns stage_hunk<cr>",                           "Stage Hunk" },
      S = { "<cmd>Gitsigns stage_buffer<cr>",                         "Stage Buffer" },
      u = { "<cmd>Gitsigns undo_stage_hunk<cr>",                      "Undo Stage Hunk" },
    },

    i = { "<cmd>ChatGPT<cr>",                                       "Open Chat" },

    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>",                 "Code Action" },
      A = { "<cmd>lua vim.lsp.buf.range_code_action()<cr>",           "Range Action" },
      d = { "<cmd>Telescope diagnostics<cr>",                         "Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>",                  "Format" },
      i = { "<cmd>LspInfo<cr>",                                       "Info" },
      q = { "<cmd>Telescope quickfix<cr>",                            "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>",                      "Rename" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",       "Workspace Symbols" },
      t = { toggle_lsp,                                               "Toggle LSP" },
      u = { "<cmd>Telescope lsp_references<cr>",                      "References" },
    },

    t = {
      name = "Telescope",
      t = { "<cmd>Telescope resume<cr>",                              "Resume" },
      g = { "<cmd>Telescope live_grep<cr>",                           "Live Grep" },
      a = { "<cmd>Telescope grep_string<cr>",                         "Grep String" },
      y = { "<cmd>Telescope neoclip<cr>",                             "Neoclip" },
    },

    ["<leader>"] = { "<cmd>Telescope buffers<cr>",                    "Choose Buffer" },
    o            = { "<cmd>Telescope find_files<cr>",                 "Open File" },
    j            = { "<cmd>Telescope jumplist<cr>",                   "Jumplist" },
    b            = { "<cmd>BufferPick<cr>",                           "Pick Buffer" },
    d            = { "<cmd>BufferClose<cr>",                          "Close Buffer" },
    -- d            = {"<cmd>bp|bd #<cr>",                               "Close Buffer"},
    p            = { prose_mode,                                      "Toggle Prose Mode" },
    w            = { toggle_wrap,                                     "Toggle Wrap" },
    q            = { "<cmd>cclose<cr>",                               "Close Quickfix" },

    s = {
      name = "Search and Replace",
      r = { "<cmd>lua require('ssr').open()<cr>", "ssr" },
      q = { "<cmd>lua require('replacer').run()<cr>", "in quickfix" },
    },
  },

  -- shortcuts
  ["[c"]    = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",        "Prev Git Hunk" },
  ["]c"]    = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>",        "Next Git Hunk" },
  ["<c-k>"] = { "<cmd>lua vim.lsp.buf.hover()<cr>",                   "Hover Doc" },
  ["<c-]>"] = { "<cmd>lua vim.lsp.buf.definition()<cr>",              "Go to Definition" },
  ["[d"]    = { "<cmd>lua vim.diagnostic.goto_prev()<cr>",            "Prev Diagnostic" },
  ["]d"]    = { "<cmd>lua vim.diagnostic.goto_next()<cr>",            "Next Diagnostic" },
  ["[b"]    = { "<cmd>BufferPrevious<cr>",                            "Prev Buffer" },
  ["]b"]    = { "<cmd>BufferNext<cr>",                                "Next Buffer" },
  ["[q"]    = { "<cmd>cprevious<cr>",                                 "Prev Quickfix Entry" },
  ["]q"]    = { "<cmd>cnext<cr>",                                     "Next Quickfix Entry" },
  ["<c-p>"] = { "<cmd>Telescope neoclip<cr>",                         "Neoclip" },

  ["<f12>"] = {"<cmd>10split | terminal f12 %<cr>",                   "f12" },
}

local wk = require('which-key')
wk.register(wk_nmaps)

wk.register(
  {
    i = {
      name = "ChatGPT",
      e = { function() require("chatgpt").edit_with_instructions() end, "Edit with instructions", },
      d = { "<cmd>ChatGPTRun docstring<cr>",                            "Add docstring", },
      f = { "<cmd>ChatGPTRun fix_bugs<cr>",                             "Fix bugs", },
      t = { "<cmd>ChatGPTRun add_tests<cr>",                            "Add tests", },
      i = { "<cmd>ChatGPTRun idiomatize<cr>",                           "Idiomatize", },
      s = { "<cmd>ChatGPTRun shorten<cr>",                              "Shorten", },
    },
  },
  { prefix = "<leader>", mode = "v", }
)
