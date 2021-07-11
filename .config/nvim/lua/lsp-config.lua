local M = {}

local function common_on_attach(client)
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

  require'aerial'.on_attach(client)
  -- require'lsp_signature'.on_attach(lsp_signature_cfg)
end

M.config = function()

  local lsp_config = require'lspconfig'

  lsp_config.ccls.setup {
    -- autostart = false,
    on_attach = common_on_attach
  }

  lsp_config.sumneko_lua.setup {
    -- autostart = false,
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
    on_attach = common_on_attach
  }

  lsp_config.purescriptls.setup {
    on_attach = common_on_attach
  }

  lsp_config.pylsp.setup {
    on_attach = common_on_attach
  }

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
