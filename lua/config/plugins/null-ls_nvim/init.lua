local null_ls = require('null-ls')

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.gitsigns,

    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.ocamlformat,
    null_ls.builtins.formatting.tidy.with({
        filetypes = { 'xml' },
        args = {
            '--tidy-mark',
            'no',
            '-quiet',
            '-indent',
            '-wrap',
            '-xml',
            '-',
        },
    }),

    null_ls.builtins.diagnostics.tidy,
    null_ls.builtins.diagnostics.selene,
    --[[ null_ls.builtins.diagnostics.php, ]]
    --[[ null_ls.builtins.diagnostics.phpcs, ]]
    --[[ null_ls.builtins.diagnostics.phpmd, ]]
    null_ls.builtins.diagnostics.phpstan,
    --[[ null_ls.builtins.diagnostics.phpstan.with({ ]]
    --[[     method = require('null-ls.methods').internal.DIAGNOSTICS_ON_SAVE, ]]
    --[[     to_temp_file = false, ]]
    --[[ }), ]]
    --[[ null_ls.builtins.diagnostics.eslint_d, ]]
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.erlfmt,
}

null_ls.setup({
    cmd = { 'nvim' },
    debounce = 250,
    debug = true,
    default_timeout = 5000,
    diagnostics_format = '[#{c}] #{m} (#{s})',
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
    --[[ root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git"), ]]
    update_in_insert = false,
    sources = sources,
})

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
})
