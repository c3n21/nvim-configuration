local map_opts = { noremap = true, silent = true }
local mapping_enum = require('mappings')

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
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.gitsigns,

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
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.code_actions.eslint_d,

            -- Python
            null_ls.builtins.diagnostics.ruff,
            -- null_ls.builtins.formatting.ruff,
            -- null_ls.builtins.formatting.black,
            -- require('typescript.extensions.null-ls.code-actions'),
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
            --[[ root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git"), ]]
            update_in_insert = false,
            sources = sources,
        })
    end,
}
