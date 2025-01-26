---@diagnostic disable: missing-fields
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
---@type vim.lsp.config
return {
    astro = {},
    ansiblels = {},
    bashls = {},
    clangd = {},
    cssls = {
        capabilities = capabilities,
    },
    denols = {},
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
    lua_ls = {},
    ocamllsp = {},
    gopls = {},
    marksman = {},
    nixd = {},
    pyright = {},
    yamlls = {},
    graphql = {},
    volar = {
        init_options = {
            vue = {
                hybridMode = false,
            },
        },
    },
    teal_ls = {},
    terraformls = {},
    terraform_lsp = {},
    vimls = {},
    eslint = {},
    tailwindcss = {},
    jdtls = {},
}
