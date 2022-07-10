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

local luasnip_snippets_realpath = string.format('%s/lua/config/plugins/LuaSnip/snippets', vim.fn.stdpath('config'))
local vscode_snippets_realpath =
    string.format('%s/lua/config/plugins/LuaSnip/friendly-snippets', vim.fn.stdpath('config'))
require('luasnip.loaders.from_lua').load({ paths = luasnip_snippets_realpath })
require('luasnip.loaders.from_vscode').lazy_load({ paths = { vscode_snippets_realpath } })
