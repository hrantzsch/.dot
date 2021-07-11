local M = {}

M.config = function()
  require'compe'.setup {
    enabled = true,
    autocomplete = false,
    debug = false,
    min_length = 2,
    preselect = 'always',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    --                 ﬘    m    
    source = {
      ultisnips = {kind = "   (Snippet)"},
      path = {kind = "   (Path)"},
      buffer = {kind = "   (Buffer)"},
      calc = {kind = "   (Calc)"},
      nvim_lsp = {kind = "   (LSP)"},
      nvim_lua = false,
      tags = false,
      emoji = {kind = " ﲃ  (Emoji)", filetypes={"markdown", "text"}}
    }
  }

  vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {noremap = true, silent = true, expr = true})
  vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {noremap = true, silent = true, expr = true})
  vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", {noremap = true, silent = true, expr = true})
  vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", {noremap = true, silent = true, expr = true})
  vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", {noremap = true, silent = true, expr = true})
end

return M
