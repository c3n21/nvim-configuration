require("neoconf").setup({
  -- override any of the default settings here
})

-- rust
require('rust-tools').setup({})

-- metals
local metals_config = require('metals').bare_config()
local completion = require('settings').completion

metals_config = completion(metals_config)

metals_config.settings = {
    showImplicitArguments = true,
    excludePackages = {
        'akka.actor.typed.javadsl',
        'com.github.swagger.akka.javadsl',
    },
}

local lspconfig = require('lspconfig')
local config = require('settings').get_config()

local language_servers = config.enable_lsp

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format('config.plugins.nvim-lspconfig.%s', language_server))
    ls_config = completion(ls_config)
    lspconfig[language_server].setup(ls_config)
end

