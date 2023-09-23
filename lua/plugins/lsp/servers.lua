local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
---@type lspconfig.options
return {
    astro = {},
    ansiblels = {},
    bashls = {},
    clangd = {},
    cssls = {
        capabilities = capabilities,
    },
    dockerls = {},
    svelte = {},
    html = {},
    erlangls = {},
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
