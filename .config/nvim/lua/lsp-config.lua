local M = {}

local function common_on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.o.completeopt = "menuone,noselect" -- disable scratch preview

  if client.server_capabilities.documentFormattingProvider then
    local opts = { mode = "n", buffer = nil, silent = true, noremap = true, nowait = false }
    require 'which-key'.register({
      ["<leader>f"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format Buffer" }
    }, opts)
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    local opts = { mode = "v", buffer = nil, silent = true, noremap = true, nowait = false }
    require 'which-key'.register({
      ["<leader>f"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format Range" }
    }, opts)
  end
end

local function setup_ui()
  local border = {
    { "🭽", "FloatBorder" }, { "▔", "FloatBorder" }, { "🭾", "FloatBorder" }, { "▕", "FloatBorder" },
    { "🭿", "FloatBorder" }, { "▁", "FloatBorder" }, { "🭼", "FloatBorder" }, { "▏", "FloatBorder" },
  }
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

M.config = function()
  local lsp_config = require 'lspconfig'

  setup_ui()

  -- servers without custom settings
  local servers = { 'clangd', 'hls', 'purescriptls', 'pylsp' }
  for _, lsp in ipairs(servers) do
    lsp_config[lsp].setup {
      on_attach = common_on_attach,
      flags = { debounce_text_changes = 200, }
    }
  end

  -- servers with custom settings
  lsp_config.pylsp.setup {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = { maxLineLength = 100 }
        }
      },
    },
    on_attach = common_on_attach,
    flags = { debounce_text_changes = 200, }
  }

  lsp_config.rust_analyzer.setup {
    -- assuming `rustup component add --toolchain nightly rust-analyzer`
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    on_attach = common_on_attach,
    flags = { debounce_text_changes = 200, }
  }

  lsp_config.lua_ls.setup {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim', 'use' } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
    on_attach = common_on_attach,
    flags = { debounce_text_changes = 200, }
  }

  require 'lsp_signature'.setup {
    bind = true,
    handler_opts = { border = "rounded" },
    toggle_key = '<M-x>',
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
