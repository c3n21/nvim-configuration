local log_level = 'trace' --'warn'
local packer_util = require('packer.util')
local utils = require('utils')

local packer = require('packer')

packer.startup({
    function(use)
        local use_config = function(plugin, config)
            config = config or nil
            if config == nil then
                config = utils.plugins.generate_config(plugin[1])
            end

            if not plugin.disable then
                plugin.config = config
            end

            use(plugin)
        end

        -- Packer can manage itself
        use({ 'wbthomason/packer.nvim', opt = true })

        use({
            'kyazdani42/nvim-web-devicons',
        })

        use_config({
            'jose-elias-alvarez/null-ls.nvim',
        })

        use_config({
            'ThePrimeagen/refactoring.nvim',
        })

        use_config({
            'ThePrimeagen/git-worktree.nvim',
            disable = false,
        })

        use_config({
            'rebelot/kanagawa.nvim',
        })

        -------------------------
        --- Completion Engine ---
        -------------------------

        use_config({
            'ray-x/lsp_signature.nvim',
            disable = false,
        })

        use_config({
            'hrsh7th/nvim-cmp',
            disable = false,
            requires = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-cmdline' },
                { 'rcarriga/cmp-dap' },
                { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
                --[[ { 'hrsh7th/cmp-nvim-lsp-signature-help' }, ]]
            },
        })

        use({ 'SmiteshP/nvim-navic' })

        ----------------------------
        --      nvim-lsp
        ----------------------------
        use({ 'folke/neoconf.nvim' })

        use({
            'williamboman/mason-lspconfig.nvim',
        })

        use_config({
            'williamboman/mason.nvim',
        })

        use_config({
            'neovim/nvim-lspconfig',
            disable = false,
        }, [[require('config.lsp')]])

        use({
            'mfussenegger/nvim-jdtls',
            disable = false,
            requires = { 'neoconf.nvim' },
        })

        use({
            'scalameta/nvim-metals',
            requires = { { 'nvim-lua/plenary.nvim' }, { 'neoconf.nvim' } },
        })

        use({
            'simrat39/rust-tools.nvim',
            requires = { 'neoconf.nvim' },
        })

        use({
            'folke/neodev.nvim',
            disable = false,
            requires = { 'neoconf.nvim' },
        })

        ---------
        -- DAP --
        ---------
        use_config({
            'mfussenegger/nvim-dap',
            disable = false,
        })

        use_config({
            'rest-nvim/rest.nvim',
        })

        use_config({
            'rcarriga/nvim-dap-ui',
            disable = false,
        })

        ------------------
        -- Pair plugins --
        ------------------
        use_config({
            'windwp/nvim-autopairs',
            disable = false,
        })

        use_config({
            'windwp/nvim-ts-autotag',
            disable = false,
        })

        --------------
        -- Projects --
        --------------
        use_config({
            'ahmedkhalf/project.nvim',
            disable = true,
        })

        use({
            'tpope/vim-obsession',
        })

        use({
            'tpope/vim-surround',
        })

        use({
            'nvim-treesitter/playground',
        })

        use_config({
            'kevinhwang91/nvim-treesitter', --'nvim-treesitter/nvim-treesitter',
        })

        use_config({
            'NMAC427/guess-indent.nvim',
        })

        use_config({
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter',
            requires = {
                'nvim-treesitter/nvim-treesitter',
            },
        })

        use_config({
            'anuvyklack/fold-preview.nvim',
        })

        ------------------
        -- Fuzzy Finder --
        ------------------
        use_config({
            'nvim-telescope/telescope.nvim',
            disable = false,
            requires = {
                -- { 'nvim-telescope/telescope-file-browser.nvim' },
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-ui-select.nvim' },
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                },
                {
                    'nvim-telescope/telescope-smart-history.nvim',
                    requires = { 'kkharji/sqlite.lua' },
                },
            },
        })

        ---------
        -- Git --
        ---------
        use_config({
            'sindrets/diffview.nvim',
        })

        use_config({
            'lukas-reineke/indent-blankline.nvim',
        })

        use_config({
            'mbbill/undotree',
        })

        use({
            'tpope/vim-repeat',
        })

        use_config({
            --- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#integrations
            'numToStr/Comment.nvim',
            requires = 'JoosepAlviste/nvim-ts-context-commentstring',
        })

        use_config({
            'anuvyklack/hydra.nvim',
            requires = 'anuvyklack/keymap-layer.nvim', -- needed only for pink hydras
        })

        -- Navigation

        use_config({
            'ThePrimeagen/harpoon',
            disable = false,
        })

        -------------------------
        -- Markdown for NeoVim --
        -------------------------

        use_config({
            'iamcco/markdown-preview.nvim',
            disable = true,
            run = 'cd app && yarn install',
        })

        -----------------
        -- Note Taking --
        -----------------
        use_config({
            'nvim-neorg/neorg',
            disable = false,
            requires = 'nvim-lua/plenary.nvim',
        })

        use_config({
            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
            },
        })

        -- Utils
        use_config({
            'Shatur/neovim-cmake',
        })

        use_config({
            'L3MON4D3/LuaSnip',
            disable = false,
            requires = { 'saadparwaiz1/cmp_luasnip' },
        })

        use_config({
            'folke/twilight.nvim',
        })

        use_config({
            'akinsho/toggleterm.nvim',
            disable = false,
        })

        use_config({
            'anuvyklack/pretty-fold.nvim',
            requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
        })

        use_config({
            'phaazon/hop.nvim',
        })

        use_config({
            'lewis6991/impatient.nvim',
        })

        use_config({
            'TimUntersberger/neogit',
        })

        use_config({
            'nvim-neo-tree/neo-tree.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'MunifTanjim/nui.nvim',
            },
        })

        use_config({
            'esensar/nvim-dev-container',
        })

        use_config({
            'Shatur/neovim-session-manager',
            disable = false,
        })

        use_config({
            'theHamsta/nvim-dap-virtual-text',
        })

        use_config({ 'mxsdev/nvim-dap-vscode-js', requires = { 'mfussenegger/nvim-dap' } })

        use({
            'microsoft/vscode-js-debug',
            opt = true,
            run = 'npm install --legacy-peer-deps && npm run compile',
        })
    end,
    config = {
        opt_default = false,
        snapshot = nil,
        snapshot_path = packer_util.join_paths(vim.fn.stdpath('cache'), 'packer.nvim', 'snapshots'),
        log = { log_level = log_level },
        compile_path = packer_util.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua'),
        auto_reload_compiled = true,
    },
})
