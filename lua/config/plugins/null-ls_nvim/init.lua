local null_ls = require('null-ls')
-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.phpcsfixer,
}

-- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
    cmd = { 'nvim' },
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    diagnostics_format = '#{m}',
    fallback_severity = vim.diagnostic.severity.ERROR,
    log = {
        enable = true,
        level = 'warn',
        use_console = 'async',
    },
    on_attach = nil,
    -- function(client, bufnr)
    --     if client.supports_method('textDocument/formatting') then
    --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --         vim.api.nvim_create_autocmd('BufWritePre', {
    --             group = augroup,
    --             buffer = bufnr,
    --             callback = function()
    --                 -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    --                 vim.lsp.buf.format({ bufnr = bufnr })
    --             end,
    --         })
    --     end
    -- end,
    on_init = nil,
    on_exit = nil,
    -- root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git"),
    update_in_insert = false,
    sources = sources,
})
