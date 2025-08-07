---@type vim.lsp.Config
return {
    name = 'roslyn',
    cmd = {
        'Microsoft.CodeAnalysis.LanguageServer',
        '--logLevel=Information',
        '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
        '--stdio',
    },
}
