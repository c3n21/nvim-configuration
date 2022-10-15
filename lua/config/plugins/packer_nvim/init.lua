local log_level = 'trace' --'warn'
local packer_util = require('packer.util')
local utils = require('utils')

local config = {
    {
        -- Packer can manage itself
        {
            'wbthomason/packer.nvim',
            config = '',
        },

        {
            'kyazdani42/nvim-web-devicons'
        },

        {
            'jose-elias-alvarez/null-ls.nvim',
        },

        {
            'ThePrimeagen/refactoring.nvim',
        },

        {
            'jbyuki/one-small-step-for-vimkind',
            disable = true,
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
            'neoclide/coc.nvim',
            branch = 'release',
            disable = true,
        },

        {
            'ms-jpq/coq_nvim',
            branch = 'coq',
            opt = true,
            disable = true,
        },

        {
            'ms-jpq/coq.artifacts',
            branch = 'artifacts',
            disable = true,
        },

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
                --[[ { 'hrsh7th/cmp-nvim-lsp-signature-help' }, ]]
            },
        },

        ----------------------------
        --      nvim-lsp
        ----------------------------
        {
            'neovim/nvim-lspconfig',
            disable = false,
        },

        {
            'mfussenegger/nvim-jdtls',
            disable = false,
            ft = 'java',
        },

        {
            'glepnir/lspsaga.nvim',
            disable = true,
        },

        {
            'scalameta/nvim-metals',
            requires = { 'nvim-lua/plenary.nvim' },
        },

        {
            'simrat39/rust-tools.nvim',
        },

        {
            'folke/neodev.nvim',
            disable = false,
        },

        ---------
        -- DAP --
        ---------
        {
            'mfussenegger/nvim-dap',
            disable = false,
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
            'ms-jpq/chadtree',
            disable = true,
            branch = 'chad',
            run = 'python3 -m chadtree deps',
        },

        {
            'kyazdani42/nvim-tree.lua',
            disable = true,
        },

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
            'nvim-treesitter/nvim-treesitter',
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

        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
            requires = {
                {
                    'nvim-treesitter/nvim-treesitter',
                },
            },
            disable = true,
        },

        {
            'romgrk/nvim-treesitter-context',
            after = 'nvim-treesitter',
            requires = {
                {
                    'nvim-treesitter/nvim-treesitter',
                },
            },
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
            'tpope/vim-fugitive',
        },

        {
            'sindrets/diffview.nvim',
        },

        {
            'akinsho/bufferline.nvim',
            disable = true,
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
            'KabbAmine/zeavim.vim',
            disable = false,
        },

        {
            --- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#integrations
            'numToStr/Comment.nvim',
            requires = 'JoosepAlviste/nvim-ts-context-commentstring',
        },

        {
            'terrortylor/nvim-comment',
            disable = true,
        },

        {
            'anuvyklack/hydra.nvim',
            requires = 'anuvyklack/keymap-layer.nvim', -- needed only for pink hydras
        },

        -- Navigation

        {
            'ThePrimeagen/harpoon',
            disable = true,
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
            'vimwiki/vimwiki',
            disable = true,
        },

        {
            'nvim-lua/plenary.nvim',
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
            'nikvdp/neomux',
            disable = true,
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
            'folke/zen-mode.nvim',
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
            'Shatur/neovim-session-manager'
        },
    },

    config = {
        snapshot = nil,
        snapshot_path = vim.fn.stdpath('config') .. '/lua/snapshots',
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

return config
