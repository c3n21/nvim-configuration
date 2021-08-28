-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
local packer = require('packer')

local coc_extensions = {
    {"fannheyward/coc-markdownlint"},
    {"fannheyward/coc-pyright"},
    {"neoclide/coc-git"},
    {"neoclide/coc-html"},
    {"neoclide/coc-json"},
    {"neoclide/coc-lists"},
    {"neoclide/coc-pairs"},
    {"neoclide/coc-prettier"},
    {"neoclide/coc-tsserver"},
    {"xiyaowong/coc-sumneko-lua"},
}

return packer.startup({
    function(use)
    -- Packer can manage itself
    --use 'wbthomason/packer.nvim'
    use {
        'c3n21/packer.nvim',
        branch = 'snapshot',
    }

    use {
        'neoclide/coc.nvim',
        branch = 'release',
        requires = coc_extensions
    }

    use {
        'jbyuki/one-small-step-for-vimkind',
        disable = true,
        config = [[require('config.nvim-dap')]]
    }

    use {
        'ThePrimeagen/git-worktree.nvim',
        config = [[require('config.git-worktree')]]
    }

    use {
        'dikiaap/minimalist',
        disable = true
    }

    use {
        'morhetz/gruvbox'
    }

    --nvim-LSP

    use {
        'mfussenegger/nvim-dap',
        disable = false,
    }

    use {
        'windwp/nvim-autopairs',
        disable = true,
        config = [[require('config.nvim-autopairs')]]
    }

    use {
        'mfussenegger/nvim-jdtls',
        disable = true,
        --config = [[require('config.nvim-jdtls.nvim-jdtls')]]
    }

    use {
        'glepnir/lspsaga.nvim',
        disable = true,
        config = [[require('config.lspsaga')]]
    }

    use {
        'neovim/nvim-lspconfig',
        disable = true,
        config = [[require('config.nvim-lspconfig')]]
    }

    use {
        'nvim-lua/completion-nvim',
        disable = true
    }

    use {
        'hrsh7th/nvim-compe',
        disable = true,
        config = [[require('config.nvim-compe')]],
        requires = {
            {'hrsh7th/vim-vsnip'},
        }
    }

    use {
        'tpope/vim-obsession'
    }

    use {
        'tpope/vim-surround'
    }

    -- use 'liuchengxu/eleline.vim'

    use {
        'nvim-treesitter/nvim-treesitter',
        config = [[require('config.nvim-treesitter')]],
    }

    use {
        'nvim-treesitter/nvim-treesitter-refactor',
        requires = { {'nvim-treesitter/nvim-treesitter'} }
    }

    use {
       'nvim-treesitter/nvim-treesitter-textobjects',
        requires = { {'nvim-treesitter/nvim-treesitter'} }
    }

    use 'romgrk/nvim-treesitter-context'

    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    use {
        'tjdevries/astronauta.nvim',
        disable = true
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = [[require('config.telescope')]],
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
    }

    -- UltiSnips
    -- use 'SirVer/ultisnips'

    use {
        'sheerun/vim-polyglot',
--        ft = {'fsharp'},
        disable = false
    }

    use {
        'tpope/vim-fugitive'
    }

    use {
        'akinsho/nvim-bufferline.lua',
        config = [[require('config.nvim-bufferline')]]
    }
end, config = {snapshot = nil} })

