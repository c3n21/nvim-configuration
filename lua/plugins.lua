-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'dikiaap/minimalist'

    use {
        'hrsh7th/nvim-compe',
        requires = {
            {'hrsh7th/vim-vsnip'},
            {'neovim/nvim-lspconfig'}
        }
    }

    use 'tpope/vim-obsession'
    use 'tpope/vim-surround'

    -- use 'liuchengxu/eleline.vim'

    -- Beautify
    use 'ryanoasis/vim-devicons'

    use {
        'nvim-treesitter/nvim-treesitter-refactor',
        requires = { {'nvim-treesitter/nvim-treesitter'} }
    }
    use {
       'nvim-treesitter/nvim-treesitter-textobjects',
        requires = { {'nvim-treesitter/nvim-treesitter'} }
    }

    use 'romgrk/nvim-treesitter-context'

    use 'tjdevries/astronauta.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} , {'fannheyward/telescope-coc.nvim'} }
    }
    -- UltiSnips
    -- use 'SirVer/ultisnips'

    use 'sheerun/vim-polyglot'

    -- LSP diagnostics
    use 'kyazdani42/nvim-web-devicons'
    use 'folke/lsp-trouble.nvim'

end)
