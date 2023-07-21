local lspconfig = require('lspconfig')
---@type lspconfig.options
return {
    ansiblels = {},
    bashls = {},
    clangd = {},
    cssls = {},
    dockerls = {},
    svelte = {},
    html = {},
    intelephense = {
        -- root_dir = lspconfig.util.root_pattern('composer.json'),
        root_dir = lspconfig.util.root_pattern('.git'),
        settings = {
            intelephense = {
                files = {
                    maxSize = 1000000,
                },
                diagnostics = {
                    undefinedProperties = true,
                },
            },
        },
    },
    jsonls = {
        settings = {
            json = {
                format = {
                    enable = true,
                },
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
    },
    gopls = {},
    marksman = {},
    nil_ls = {},
    pyright = {},
    yamlls = {},
    lua_ls = {},
    teal_ls = {},
    vimls = {},
    --[[ tailwindcss = {}, ]]
}
