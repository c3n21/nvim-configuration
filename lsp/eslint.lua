local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

--- @type vim.lsp.Config
return {
    capabilities = capabilities,
}
