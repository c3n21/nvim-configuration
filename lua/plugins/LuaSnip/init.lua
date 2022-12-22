return {
    'L3MON4D3/LuaSnip',
    config = function()
        local luasnip = require('luasnip')
        local types = require('luasnip.util.types')

        luasnip.config.set_config({
            history = true,
            updateevents = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = {
                            {
                                '<-',
                                'Error',
                            },
                        },
                    },
                },
            },
        })

        --local luasnip_snippets_realpath = string.format('%s/lua/config/plugins/LuaSnip/snippets', vim.fn.stdpath('config'))
        --local vscode_snippets_realpath =
        --string.format('%s/lua/config/plugins/LuaSnip/friendly-snippets', vim.fn.stdpath('config'))
        --require('luasnip.loaders.from_lua').load({ paths = luasnip_snippets_realpath })
        --require('luasnip.loaders.from_vscode').lazy_load({ paths = { vscode_snippets_realpath } })

        vim.keymap.set({ 'i', 's' }, '<c-l>', function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { noremap = true, silent = true })

        vim.keymap.set({ 'i', 's' }, '<c-j>', function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { noremap = true, silent = true })

        vim.keymap.set({ 'i', 's' }, '<c-k>', function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { noremap = true, silent = true })

        vim.keymap.set(
            { 'n' },
            '<leader><leader>s',
            '<cmd> source ~/.config/nvim/lua/config/plugins/LuaSnip/init.lua <CR>',
            { noremap = true, silent = true }
        )
    end,
}
