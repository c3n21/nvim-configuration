local h = require('null-ls.helpers')
local null_ls = require('null-ls')

local severities = {
    Warning = vim.diagnostic.severity.WARN,
    Error = vim.diagnostic.severity.ERROR,
}
-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.tidy,
    null_ls.builtins.diagnostics.tidy.with({
        args = function(params)
            local common_args = {
                '-quiet',
                '-errors',
            }
            if params.ft == 'xml' then
                table.insert(common_args, 1, '-xml')
            end

            return common_args
        end,
        on_output = h.diagnostics.from_pattern(
            [[line (%d+) column (%d+) %- (%a+): (.+)]],
            { 'row', 'col', 'severity', 'message' },
            { severities = severities }
        ),
    }),
    --[[ null_ls.builtins.diagnostics.phpcs, ]]
    --[[ null_ls.builtins.diagnostics.phpmd, ]]
    --[[ null_ls.builtins.diagnostics.phpstan, ]]
}

null_ls.setup({
    cmd = { 'nvim' },
    debounce = 250,
    debug = true,
    default_timeout = 1000,
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
