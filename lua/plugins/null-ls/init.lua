local map_opts = { noremap = true, silent = true }
local mapping_enum = require('mappings')

return {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'folke/neoconf.nvim',
    },
    config = function()
        local null_ls = require('null-ls')
        local on_attach = require('plugins.lsp.on_attach')

        -- register any number of sources simultaneously
        local sources = {
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.gitsigns,

            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettierd.with({
                extra_filetypes = { 'java' },
            }),
            null_ls.builtins.formatting.phpcsfixer,
            null_ls.builtins.formatting.rustfmt,
            null_ls.builtins.formatting.ocamlformat,
            null_ls.builtins.formatting.tidy.with({
                filetypes = { 'xml', 'fxml' },
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
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.formatting.erlfmt,

            -- Python
            null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.formatting.autopep8,
            -- null_ls.builtins.formatting.ruff,
            -- null_ls.builtins.formatting.black,
            require('typescript.extensions.null-ls.code-actions'),
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
            on_attach = on_attach.format_attach,
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

        vim.keymap.set({ 'n', 'v' }, mapping_enum['CodeActions'], vim.lsp.buf.code_action, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['OpenFloatDiagnostic'], vim.diagnostic.open_float, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['PrevDiagnosticInfo'], function()
            vim.diagnostic.goto_prev({ wrap = false, severity = { max = vim.diagnostic.severity.INFO } })
        end, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['NextDiagnosticInfo'], function()
            vim.diagnostic.goto_next({ wrap = false, severity = { max = vim.diagnostic.severity.INFO } })
        end, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['PrevDiagnosticWarning'], function()
            vim.diagnostic.goto_prev({ wrap = false, severity = vim.diagnostic.severity.WARN })
        end, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['NextDiagnosticWarning'], function()
            vim.diagnostic.goto_next({ wrap = false, severity = vim.diagnostic.severity.WARN })
        end, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['PrevDiagnosticError'], function()
            vim.diagnostic.goto_prev({ wrap = false, severity = vim.diagnostic.severity.ERROR })
        end, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['NextDiagnosticError'], function()
            vim.diagnostic.goto_next({ wrap = false, severity = vim.diagnostic.severity.ERROR })
        end, map_opts)
        vim.keymap.set({ 'n' }, mapping_enum['OpenDiagnosticLoclist'], vim.diagnostic.setloclist, map_opts)
    end,
}
