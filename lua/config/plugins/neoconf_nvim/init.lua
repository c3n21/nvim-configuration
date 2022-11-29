require('neoconf').setup(
-- override any of the default settings here
    --[[ { ]]
    --[[     -- name of the local settings files ]]
    --[[     local_settings = '.neoconf.json', ]]
    --[[     -- name of the global settings file in your Neovim config directory ]]
    --[[     global_settings = 'neoconf.json', ]]
    --[[     -- import existing settinsg from other plugins ]]
    --[[     import = { ]]
    --[[         vscode = true, -- local .vscode/settings.json ]]
    --[[         coc = true, -- global/local coc-settings.json ]]
    --[[         nlsp = true, -- global/local nlsp-settings.nvim json settings ]]
    --[[     }, ]]
    --[[     -- send new configuration to lsp clients when changing json settings ]]
    --[[     live_reload = true, ]]
    --[[     -- set the filetype to jsonc for settings files, so you can use comments ]]
    --[[     -- make sure you have the jsonc treesitter parser installed! ]]
    --[[     filetype_jsonc = true, ]]
    --[[     plugins = { ]]
    --[[         -- configures lsp clients with settings in the following order: ]]
    --[[         -- - lua settings passed in lspconfig setup ]]
    --[[         -- - global json settings ]]
    --[[         -- - local json settings ]]
    --[[         lspconfig = { ]]
    --[[             enabled = true, ]]
    --[[         }, ]]
    --[[         -- configures jsonls to get completion in .nvim.settings.json files ]]
    --[[         jsonls = { ]]
    --[[             enabled = true, ]]
    --[[             -- only show completion in json settings for configured lsp servers ]]
    --[[             configured_servers_only = true, ]]
    --[[         }, ]]
    --[[         -- configures sumneko_lua to get completion of lspconfig server settings ]]
    --[[         sumneko_lua = { ]]
    --[[             -- by default, sumneko_lua annotations are only enabled in your neovim config directory ]]
    --[[             enabled_for_neovim_config = true, ]]
    --[[             -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file ]]
    --[[             enabled = false, ]]
    --[[         }, ]]
    --[[     }, ]]
    --[[ } ]]
)

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
--[[ local language_servers = {
    'pyright',
    'tsserver',
    'clangd',
    'dartls',
    'ocamllsp',
    'intelephense',
    'tailwindcss',
    'erlangls',
    'eslint',
    -- 'rust_analyzer',
    -- "sumneko_lua" using lua-dev
    -- "fsautocomplete",
    -- "rnix",
    -- "efm"
} ]]

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format('config.plugins.nvim-lspconfig.%s', language_server))
    ls_config = completion(ls_config)
    ls_config.on_attach = on_attach
    lspconfig[language_server].setup(ls_config)
end

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
