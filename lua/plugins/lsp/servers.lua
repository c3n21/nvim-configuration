---@type lspconfig.options
return {
    ansiblels = {},
    bashls = {},
    clangd = {},
    cssls = {},
    dockerls = {},
    --[[ tsserver = {}, ]]
    svelte = {},
    --[[ eslint = {}, ]]
    html = {},
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
    pyright = {},
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                cargo = { allFeatures = true },
                checkOnSave = {
                    command = 'clippy',
                    extraArgs = { '--no-deps' },
                },
            },
        },
    },
    yamlls = {},
    lua_ls = {},
    teal_ls = {},
    vimls = {},
    --[[ tailwindcss = {}, ]]
}
