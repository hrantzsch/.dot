vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
  jump = {
    float = true,
    severity = vim.diagnostic.severity.ERROR,
  },
  float = { source = "always" },
})

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
  end,
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('pylsp')
vim.lsp.enable('clojure_lsp')
