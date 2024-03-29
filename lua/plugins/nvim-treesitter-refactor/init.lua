return {
    'nvim-treesitter/nvim-treesitter-refactor',
    config = function()
        require('nvim-treesitter.configs').setup({
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = true },
                navigation = {
                    enable = false,
                    keymaps = {
                        goto_definition = 'gnd',
                        list_definitions = 'gnD',
                        list_definitions_toc = 'gO',
                        goto_next_usage = '<a-*>',
                        goto_previous_usage = '<a-#>',
                    },
                },
                smart_rename = {
                    enable = true,
                    keymaps = {
                        smart_rename = 'grr',
                    },
                },
            },
        })
    end,
}
