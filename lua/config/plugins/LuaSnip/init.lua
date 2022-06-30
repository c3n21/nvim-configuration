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

local snippets_realpath = string.format('%s/lua/config/plugins/LuaSnip/snippets', vim.fn.stdpath('config'))
require('luasnip.loaders.from_lua').load({ paths = snippets_realpath })
