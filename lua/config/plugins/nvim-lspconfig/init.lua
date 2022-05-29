local lspconfig = require'lspconfig'
local system_config = require("settings").get_config()
local current = system_config.completion.current

local language_servers = system_config.enable_lsp

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format("config.plugins.nvim-lspconfig.%s", language_server))
    ls_config = system_config.completion[current](ls_config)
    lspconfig[language_server].setup(ls_config)
end
