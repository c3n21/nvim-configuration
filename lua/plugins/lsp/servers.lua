---@type lspconfig.options
return {
    ansiblels = {},
    bashls = {},
    clangd = {},
    cssls = {},
    dockerls = {},
    svelte = {},
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
    nil_ls = {},
    pyright = {},
    yamlls = {},
    lua_ls = {},
    teal_ls = {},
    vimls = {},
    --[[ tailwindcss = {}, ]]
}
