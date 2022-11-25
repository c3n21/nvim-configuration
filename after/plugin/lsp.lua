local on_attach = require('config.plugins.nvim-lspconfig.navic')

-- rust
require('rust-tools').setup({ on_attach = on_attach })

-- metals
local metals_config = require('metals').bare_config()
local completion = require('settings').completion

metals_config = completion(metals_config)
metals_config.on_attach = on_attach

metals_config.settings = {
    showImplicitArguments = true,
    excludePackages = {
        'akka.actor.typed.javadsl',
        'com.github.swagger.akka.javadsl',
    },
}

require('neodev').setup({
    library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
    -- add any options here, or leave empty to use the default settings
})

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')

-- example to setup sumneko and enable call snippets
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            --[[ diagnostics = {
                -- Get the language server to recognize the `vim` global
            }, ]]
            workspace = {
                maxPreload = 5000,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },

            completion = {
                callSnippet = 'Replace',
            },
        },
    },
})

local config = require('settings').get_config()

local language_servers = config.enable_lsp

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format('config.plugins.nvim-lspconfig.%s', language_server))
    ls_config = completion(ls_config)
    ls_config.on_attach = on_attach
    lspconfig[language_server].setup(ls_config)
end

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
