local M = {}

local function common_on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.o.completeopt = "menuone,noselect" -- disable scratch preview

  if client.resolved_capabilities.document_formatting then
    local opts = { mode = "n", buffer = nil, silent = true, noremap = true, nowait = false }
    require'which-key'.register({
      ["<leader>f"] = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format Buffer"}
    }, opts)
  end

  if client.resolved_capabilities.document_range_formatting then
    local opts = { mode = "v", buffer = nil, silent = true, noremap = true, nowait = false }
    require'which-key'.register({
      ["<leader>f"] = {"<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format Range"}
    }, opts)
  end

end

M.config = function()

  local lsp_config = require'lspconfig'

  -- servers without custom settings
  local servers = { 'ccls', 'purescriptls', 'pylsp' }
  for _, lsp in ipairs(servers) do
    lsp_config[lsp].setup {
      on_attach = common_on_attach,
      flags = { debounce_text_changes = 200, }
    }
  end

  lsp_config.rls.setup {
    settings = {
      rust = {
        unstable_features = true,
        build_on_save = true,
        all_features = true,
      },
    },
    on_attach = common_on_attach,
    flags = { debounce_text_changes = 200, }
  }

  lsp_config.sumneko_lua.setup {
    cmd = {'/usr/bin/lua-language-server'};
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },
        diagnostics = { -- don't warn for undefined globals
        globals = {'vim', 'use'},
        },
        workspace = { -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        telemetry = { enable = false, },
      },
    },
    on_attach = common_on_attach,
    flags = { debounce_text_changes = 200, }
  }

  require'lsp_signature'.setup({
    bind = true,
    handler_opts = { border = "shadow" },
    toggle_key = '<M-x>',
  })


end

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

return M
