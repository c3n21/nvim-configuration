return {
    'kylechui/nvim-surround',
    dependencies = {
        'kevinhwang91/nvim-treesitter', --'nvim-treesitter/nvim-treesitter',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('nvim-surround').setup({})
    end,
}
