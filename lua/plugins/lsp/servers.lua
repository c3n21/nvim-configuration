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
    sumneko_lua = {
        -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
        single_file_support = true,
        settings = {
            Lua = {
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                completion = {
                    workspaceWord = true,
                    callSnippet = 'Both',
                },
                misc = {
                    parameters = {
                        '--log-level=trace',
                    },
                },
                diagnostics = {
                    -- enable = false,
                    groupSeverity = {
                        strong = 'Warning',
                        strict = 'Warning',
                    },
                    groupFileStatus = {
                        ['ambiguity'] = 'Opened',
                        ['await'] = 'Opened',
                        ['codestyle'] = 'None',
                        ['duplicate'] = 'Opened',
                        ['global'] = 'Opened',
                        ['luadoc'] = 'Opened',
                        ['redefined'] = 'Opened',
                        ['strict'] = 'Opened',
                        ['strong'] = 'Opened',
                        ['type-check'] = 'Opened',
                        ['unbalanced'] = 'Opened',
                        ['unused'] = 'Opened',
                    },
                    unusedLocalExclude = { '_*' },
                },
                format = {
                    enable = false,
                    defaultConfig = {
                        indent_style = 'space',
                        indent_size = '2',
                        continuation_indent_size = '2',
                    },
                },
            },
        },
    },
    teal_ls = {},
    vimls = {},
    --[[ tailwindcss = {}, ]]
}
