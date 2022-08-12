local log_level = 'trace' --'warn'
local util = require('packer.util')

local function sanitize(plugin_name)
    local result = vim.split(plugin_name, '/', {
        plain = true,
        trimempty = true,
    })

    local sanitized_name = result[#result]

    sanitized_name = vim.fn.substitute(sanitized_name, '\\.', '_', 'g')

    return sanitized_name
end

local function generate_config(plugin_name)
    local path = require('plenary.path')

    local sane_plugin_name = sanitize(plugin_name)

    local plugin_path = path:new(vim.fn.stdpath('config'), 'lua', 'config', 'plugins', sane_plugin_name)

    local plugin_init = plugin_path:joinpath('init.lua')

    if vim.fn.filereadable(tostring(plugin_init)) == 0 then
        vim.fn.mkdir(tostring(plugin_path), 'p')
        vim.fn.writefile({}, tostring(plugin_init))
    end

    return [[require('config.plugins.]] .. sane_plugin_name .. [[')]]
end

local config = {
    {
        -- Packer can manage itself
        {
            'wbthomason/packer.nvim',
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
            'hrsh7th/cmp-nvim-lsp-signature-help',
            disable = false,
        },

        {
            'hrsh7th/nvim-cmp',
            disable = false,
            requires = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-cmdline' },
            },
        },

        ----------------------------
        --      nvim-lsp
        ----------------------------
        {
            'scalameta/nvim-metals',
            requires = { 'nvim-lua/plenary.nvim' },
        },

        {
            'simrat39/rust-tools.nvim',
        },

        {
            'ms-jpq/chadtree',
            disable = false,
            branch = 'chad',
            run = 'python3 -m chadtree deps',
        },

        -- DAP --

        {
            'mfussenegger/nvim-dap',
            disable = false,
        },

        {
            'rcarriga/nvim-dap-ui',
            disable = false,
        },

        {
            'windwp/nvim-autopairs',
            disable = false,
        },

        {
            'windwp/nvim-ts-autotag',
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
            'neovim/nvim-lspconfig',
            disable = false,
        },
        {
            'ahmedkhalf/project.nvim',
            disable = false,
        },

        {
            'folke/lua-dev.nvim',
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

        {
            'nvim-telescope/telescope.nvim',
            disable = false,
            requires = {
                -- { 'nvim-telescope/telescope-file-browser.nvim' },
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-ui-select.nvim' },
            },
        },

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
            disable = true,
        },

        {
            'anuvyklack/pretty-fold.nvim',
            requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
        },
        {
            'phaazon/hop.nvim',
        },
    },

    config = {
        snapshot = nil,
        snapshot_path = vim.fn.stdpath('config') .. '/lua/snapshots',
        log = { log_level = log_level },
        compile_path = util.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua'),
        auto_reload_compiled = true,
    },
}

for _, plugin in pairs(config[1]) do
    if not plugin.config then
        plugin.config = generate_config(plugin[1])
    end
end

return config
