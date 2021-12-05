local system_config = require('config')
local current = system_config.completion.current


local sumneko_root_path = "/usr/lib/lua-language-server"
local sumneko_binary = "/bin/lua-language-server"


local lspconfig = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
            },
            workspace = {
                maxPreload = 5000
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig = system_config.completion[current](lspconfig)

local config = {
    library = {
        vimruntime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    -- pass any additional options that will be merged in the final lsp config
    lspconfig = lspconfig
}

local luadev = require("lua-dev").setup(config)

return luadev
