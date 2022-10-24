local lspconfig = require('lspconfig')
local config = require('settings').get_config()
local completion = require('settings').completion

local language_servers = config.enable_lsp

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format('config.plugins.nvim-lspconfig.%s', language_server))
    ls_config = completion(ls_config)
    lspconfig[language_server].setup(ls_config)
end

