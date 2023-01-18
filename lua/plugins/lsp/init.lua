return {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    event = 'BufReadPre',
    dependencies = {
        'folke/neodev.nvim',
        'folke/neoconf.nvim',
        'ray-x/lsp_signature.nvim',
        'simrat39/rust-tools.nvim',
        'SmiteshP/nvim-navic',
        'nvim-telescope/telescope.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'smjonas/inc-rename.nvim',
        'b0o/schemastore.nvim',
    },

    config = function()
        require('neoconf').setup()
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
            override = function(root_dir, options) end,
            -- add any options here, or leave empty to use the default settings
        })

        local servers = require('plugins.lsp.servers')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        local on_attach = require('plugins.lsp.on_attach')

        local options = {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        }

        -- rust
        --[[ require('rust-tools').setup({ server = { on_attach = on_attach } }) ]]

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

        -- then setup your lsp server as usual
        local lspconfig = require('lspconfig')

        for ls_name, ls_config in pairs(servers) do
            local opts = vim.tbl_deep_extend('force', {}, options, ls_config or {})
            lspconfig[ls_name].setup(opts)
        end
    end,
}
