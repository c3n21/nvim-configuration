local log_level = 'trace' --'warn'
local packer_util = require('packer.util')
local utils = require('utils')

local config = {
    {
        -- Packer can manage itself
        { 'wbthomason/packer.nvim', opt = true, config = '' },

        {
            'kyazdani42/nvim-web-devicons',
            config = '',
        },

        { 'folke/neoconf.nvim', config = '' },

        {
            'jose-elias-alvarez/null-ls.nvim',
        },

        {
            'ThePrimeagen/refactoring.nvim',
        },

        {
            'ThePrimeagen/git-worktree.nvim',
            disable = false,
        },

        {
            'rebelot/kanagawa.nvim',
        },

        -------------------------
        --- Completion Engine ---
        -------------------------

        {
            'ray-x/lsp_signature.nvim',
            disable = false,
        },

        {
            'hrsh7th/nvim-cmp',
            disable = false,
            requires = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-cmdline' },
                { 'rcarriga/cmp-dap' },
                { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
                { 'rcarriga/cmp-dap' },
                --[[ { 'hrsh7th/cmp-nvim-lsp-signature-help' }, ]]
            },
        },

        { 'SmiteshP/nvim-navic', config = '' },

        ----------------------------
        --      nvim-lsp
        ----------------------------
        {
            'neovim/nvim-lspconfig',
            disable = false,
            config = '',
        },

        {
            'mfussenegger/nvim-jdtls',
            disable = false,
            config = '',
        },

        {
            'glepnir/lspsaga.nvim',
            disable = true,
        },

        {
            'scalameta/nvim-metals',
            requires = { 'nvim-lua/plenary.nvim' },
            config = '',
        },

        {
            'simrat39/rust-tools.nvim',
            config = '',
        },

        {
            'folke/neodev.nvim',
            disable = false,
            config = '',
        },

        ---------
        -- DAP --
        ---------
        {
            'mfussenegger/nvim-dap',
            disable = false,
        },

        {
            'rest-nvim/rest.nvim',
        },

        {
            'rcarriga/nvim-dap-ui',
            disable = false,
        },

        ------------------
        -- Pair plugins --
        ------------------
        {
            'windwp/nvim-autopairs',
            disable = false,
        },

        {
            'windwp/nvim-ts-autotag',
            disable = false,
        },

        --------------
        -- Projects --
        --------------
        {
            'ahmedkhalf/project.nvim',
            disable = false,
        },

        {
            'tpope/vim-obsession',
        },

        {
            'tpope/vim-surround',
        },

        {
            'nvim-treesitter/playground',
        },

        {
            'kevinhwang91/nvim-treesitter', --'nvim-treesitter/nvim-treesitter',
        },

        {
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter',
            require = {
                'nvim-treesitter/nvim-treesitter',
            },
        },

        {
            'anuvyklack/fold-preview.nvim',
        },

        ------------------
        -- Fuzzy Finder --
        ------------------
        {
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
        },

        ---------
        -- Git --
        ---------
        {
            'sindrets/diffview.nvim',
        },

        {
            'lukas-reineke/indent-blankline.nvim',
        },

        {
            'mbbill/undotree',
        },

        {
            'tpope/vim-sleuth',
            disable = false,
        },

        {
            'tpope/vim-repeat',
        },

        {
            --- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#integrations
            'numToStr/Comment.nvim',
            requires = 'JoosepAlviste/nvim-ts-context-commentstring',
        },

        {
            'anuvyklack/hydra.nvim',
            requires = 'anuvyklack/keymap-layer.nvim', -- needed only for pink hydras
        },

        -- Navigation

        {
            'ThePrimeagen/harpoon',
            disable = false,
        },

        -------------------------
        -- Markdown for NeoVim --
        -------------------------

        {
            'iamcco/markdown-preview.nvim',
            disable = false,
            run = 'cd app && yarn install',
        },

        -----------------
        -- Note Taking --
        -----------------
        {
            'nvim-neorg/neorg',
            disable = false,
            requires = 'nvim-lua/plenary.nvim',
        },

        {
            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
            },
        },

        -- Utils
        {
            'Shatur/neovim-cmake',
        },
        {
            'L3MON4D3/LuaSnip',
            disable = false,
            requires = { 'saadparwaiz1/cmp_luasnip' },
        },

        {
            'folke/twilight.nvim',
        },

        {
            'akinsho/toggleterm.nvim',
            disable = false,
        },

        {
            'anuvyklack/pretty-fold.nvim',
            requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
        },
        {
            'phaazon/hop.nvim',
        },
        {
            'lewis6991/impatient.nvim',
        },
        {
            'TimUntersberger/neogit',
        },
        {
            'nvim-neo-tree/neo-tree.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'MunifTanjim/nui.nvim',
            },
        },
        {
            'esensar/nvim-dev-container',
        },

        {
            'Shatur/neovim-session-manager',
        },

        {
            'theHamsta/nvim-dap-virtual-text',
        },

        {
            'microsoft/vscode-js-debug',
            opt = true,
            config = '',
            run = 'git reset --hard && npm cache clear --force && npm install --legacy-peer-deps && npm run compile',
        },

        { 'mxsdev/nvim-dap-vscode-js', requires = { 'mfussenegger/nvim-dap' } },
    },

    config = {
        opt_default = false,
        snapshot = nil,
        snapshot_path = packer_util.join_paths(vim.fn.stdpath('config'), 'lua', 'snapshots'),
        log = { log_level = log_level },
        compile_path = packer_util.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua'),
        auto_reload_compiled = true,
    },
}

for _, plugin in pairs(config[1]) do
    if not plugin.config then
        plugin.config = utils.plugins.generate_config(plugin[1])
    end
end

local packer = require('packer')

packer.startup(config)
