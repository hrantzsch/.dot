vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank { timeout = 250 } end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = { "/dev/shm/pass.?*/?*.txt", "$TMPDIR/pass.?*/?*.txt", "/tmp/pass.?*/?*.txt" },
  callback = function()
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.swapfile = false
    vim.opt.viminfo = ''
    vim.opt.undofile = false
    vim.api.nvim_echo({ { "Editing password without leaky options", "None" } }, false, {})
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py" },
  callback = function() vim.lsp.buf.format() end,
})
