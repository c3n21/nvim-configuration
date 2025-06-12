local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

--- @type vim.lsp.Config
return {
    flags = {
        debounce_text_changes = 150,
        allow_incremental_sync = false,
        exit_timeout = false,
    },
    cmd = { 'astro-ls', '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    capabilities = capabilities,
    init_options = {
        typescript = {},
    },
}
