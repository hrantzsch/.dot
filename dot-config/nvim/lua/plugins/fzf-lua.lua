return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = { layout = 'flex' },
    },
    fzf_opts = { ['--layout'] = 'reverse' },
  },
  keys = {
    { "<c-p>",        "<cmd>FzfLua commands<cr>",              desc = "Commands" },
    { "<leader><leader>", "<cmd>FzfLua resume<cr>",            desc = "Resume picker" },
    { "<leader>B",    "<cmd>FzfLua buffers<cr>",               desc = "Choose Buffer" },
    { "<leader>j",    "<cmd>FzfLua jumps<cr>",                 desc = "Jumplist" },
    { "<leader>o",    "<cmd>FzfLua files<cr>",                 desc = "Open File" },
    { "<leader>R",    "<cmd>FzfLua live_grep<cr>",             desc = "Live Grep" },
    { "<leader>r",    "<cmd>FzfLua grep_cword<cr>",            desc = "Grep Word" },
    -- git
    { "<leader>go",   "<cmd>FzfLua git_status<cr>",            desc = "Open Changed File" },
    { "<leader>gc",   "<cmd>FzfLua git_bcommits<cr>",          desc = "Browse File Commits" },
  },
}
