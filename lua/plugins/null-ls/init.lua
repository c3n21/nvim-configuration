return {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'folke/neoconf.nvim',
        'lewis6991/gitsigns.nvim',
    },
    config = function()
        local null_ls = require('null-ls')
        local on_attach = require('plugins.lsp.on_attach')

        -- register any number of sources simultaneously
        local sources = {
            -- code actions
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.gitsigns,

            -- diagnostics
            null_ls.builtins.diagnostics.tidy,
            null_ls.builtins.diagnostics.selene,
            -- null_ls.builtins.diagnostics.luacheck,
            --[[ null_ls.builtins.diagnostics.php, ]]
            --[[ null_ls.builtins.diagnostics.phpcs, ]]
            --[[ null_ls.builtins.diagnostics.phpmd, ]]
            null_ls.builtins.diagnostics.phpstan,
            --[[ null_ls.builtins.diagnostics.phpstan.with({ ]]
            --[[     method = require('null-ls.methods').internal.DIAGNOSTICS_ON_SAVE, ]]
            --[[     to_temp_file = false, ]]
            --[[ }), ]]
            null_ls.builtins.diagnostics.ruff,
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
            on_attach = on_attach,
            on_init = nil,
            on_exit = nil,
            update_in_insert = false,
            sources = sources,
        })
    end,
}
