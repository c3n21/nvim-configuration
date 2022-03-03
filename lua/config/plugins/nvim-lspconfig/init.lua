local lspconfig = require'lspconfig'
local system_config = require("config")
local current = system_config.completion.current

local language_servers = {
    "pyright",
    "tsserver",
    -- "fsautocomplete",
    "clangd",
    "rnix",
    -- "efm"
}

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format("config.plugins.nvim-lspconfig.%s", language_server))
    ls_config = system_config.completion[current](ls_config)
    lspconfig[language_server].setup(ls_config)
end
