local map_opts = { noremap = true, silent = true }

return {
    'pmizio/typescript-tools.nvim',
    dependencies = {
        'lsp',
    },
    config = function()
        local mason_registry = require('mason-registry')
        local tsserver_path = mason_registry.get_package('typescript-language-server'):get_install_path()
        require('typescript-tools').setup({
            on_attach = function(client, bufnr)
                require('plugins.lsp.on_attach').lsp_attach(client, bufnr)
                vim.keymap.set({ 'n', 'i' }, '<leader>gsd', '<cmd>TSToolsGoToSourceDefinition<CR>', map_opts)
            end,
            settings = {

                -- spawn additional tsserver instance to calculate diagnostics on it
                separate_diagnostic_server = true,
                -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                publish_diagnostic_on = 'insert_leave',
                -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
                -- specify commands exposed as code_actions
                expose_as_code_action = {
                    'fix_all',
                    'add_missing_imports',
                    'remove_unused',
                },
                -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                -- not exists then standard path resolution strategy is applied
                tsserver_path = tsserver_path .. '/node_modules/typescript/lib/tsserver.js',
                -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                -- (see 💅 `styled-components` support section)
                tsserver_plugins = {},
                -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                -- memory limit in megabytes or "auto"(basically no limit)
                tsserver_max_memory = 'auto',
                -- described below
                tsserver_format_options = {},
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeCompletionsForModuleExports = true,
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        })
    end,
}
