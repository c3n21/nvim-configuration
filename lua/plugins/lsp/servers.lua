---@diagnostic disable: missing-fields
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
    lua_ls = {
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                    },
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                },
            })
        end,
        settings = {
            Lua = {},
        },
    },
    ocamllsp = {},
    gopls = {},
    marksman = {},
    nixd = {},
    pyright = {},
    yamlls = {},
    lua_ls = {},
    volar = {
        init_options = {
            vue = {
                hybridMode = false,
            },
        },
    },
    teal_ls = {},
    vimls = {},
    eslint = {},
    tailwindcss = {},
}
