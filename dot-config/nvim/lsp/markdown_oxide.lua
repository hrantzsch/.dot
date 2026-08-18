local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

---@type vim.lsp.Config
return {
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    root_markers = { '.git', '.obsidian', '.moxide.toml' },
    capabilities = capabilities,
}
