return {
    'ray-x/lsp_signature.nvim',
    enabled = false,
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    config = function()
        require('lsp_signature').setup({})
    end,
}
