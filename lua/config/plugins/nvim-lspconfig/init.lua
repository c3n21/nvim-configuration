local lspconfig = require'lspconfig'

local language_servers = {
    "pyright",
    "tsserver",
    -- "fsautocomplete",
    "clangd"
}

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format("config.plugins.nvim-lspconfig.%s", language_server))
    lspconfig[language_server].setup(ls_config)
end
