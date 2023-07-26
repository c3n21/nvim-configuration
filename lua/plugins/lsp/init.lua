return {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    event = 'BufReadPre',
    dependencies = {
        'folke/neodev.nvim',
        'folke/neoconf.nvim',
        'simrat39/rust-tools.nvim',
        'SmiteshP/nvim-navic',
        'nvim-telescope/telescope.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'smjonas/inc-rename.nvim',
        'b0o/schemastore.nvim',
        'jmbuhr/otter.nvim',
        'pmizio/typescript-tools.nvim',
        'williamboman/mason.nvim',
        'akinsho/flutter-tools.nvim',
    },
    config = function()
        require('neoconf').setup()
        -- require('otter').dev_setup()
        require('neodev').setup({
            library = {
                enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = true, -- runtime path
                types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            --[[ override = function(root_dir, options) end, ]]
            -- add any options here, or leave empty to use the default settings
            lspconfig = true,
            pathStrict = true,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        local on_attach = require('plugins.lsp.on_attach')

        local flutter_tools = require('flutter-tools')
        flutter_tools.setup({
            lsp = {
                on_attach = on_attach.lsp_attach,
            },
        })

        local options = {
            on_attach = on_attach.lsp_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        }

        local rt = require('rust-tools')
        rt.setup({
            server = {
                on_attach = function(client, bufnr)
                    on_attach.lsp_attach(client, bufnr)
                    -- Hover actions
                    vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
            },
        })

        -- metals
        --[[ local metals_config = require('metals').bare_config() ]]
        --local completion = require("settings").completion

        --metals_config = completion(metals_config)
        --[[ metals_config.on_attach = on_attach ]]

        --[[ metals_config.settings = { ]]
        --[[     showImplicitArguments = true, ]]
        --[[     excludePackages = { ]]
        --[[         'akka.actor.typed.javadsl', ]]
        --[[         'com.github.swagger.akka.javadsl', ]]
        --[[     }, ]]
        --[[ } ]]

        local mason_registry = require('mason-registry')
        local tsserver_path = mason_registry.get_package('typescript-language-server'):get_install_path()
        require('typescript-tools').setup({
            on_attach = function(client, bufnr)
                require('plugins.lsp.on_attach').lsp_attach(client, bufnr)
            end,
            settings = {

                -- spawn additional tsserver instance to calculate diagnostics on it
                separate_diagnostic_server = true,
                -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                publish_diagnostic_on = 'insert_leave',
                -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
                -- specify commands exposed as code_actions
                expose_as_code_action = {
                    'fix_all',
                    'add_missing_imports',
                    'remove_unused',
                },
                -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                -- not exists then standard path resolution strategy is applied
                tsserver_path = tsserver_path .. '/node_modules/typescript/lib/tsserver.js',
                -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                -- (see 💅 `styled-components` support section)
                tsserver_plugins = {},
                -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                -- memory limit in megabytes or "auto"(basically no limit)
                tsserver_max_memory = 'auto',
                -- described below
                tsserver_format_options = {},
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeCompletionsForModuleExports = true,
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        })

        -- then setup your lsp server as usual
        local lspconfig = require('lspconfig')

        local servers = require('plugins.lsp.servers')
        for ls_name, ls_config in pairs(servers) do
            local opts = vim.tbl_deep_extend('force', {}, options, ls_config or {})
            lspconfig[ls_name].setup(opts)
        end
    end,
}
