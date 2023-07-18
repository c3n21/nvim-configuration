local map_opts = { noremap = true, silent = true }
return {
    'jose-elias-alvarez/typescript.nvim',
    dependencies = {
        'folke/neoconf.nvim',
        'folke/noice.nvim',
    },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    enabled = false,
    config = function()
        require('typescript').setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            go_to_source_definition = {
                fallback = true, -- fall back to standard LSP definition on failure
            },

            server = { -- pass options to lspconfig's setup method
                on_attach = function(client, bufnr)
                    require('plugins.lsp.on_attach').lsp_attach(client, bufnr)
                    vim.keymap.set('n', '<leader>rf', '<cmd>TypescriptRenameFile<CR>', map_opts)
                    vim.keymap.set({ 'n', 'i' }, '<C>]', '<cmd>TypescriptGoToSourceDefinition<CR>', map_opts)
                end,
            },
        })
    end,
}
