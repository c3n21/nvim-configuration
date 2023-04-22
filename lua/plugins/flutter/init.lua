return {
    'akinsho/flutter-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local on_attach = require('plugins.lsp.on_attach')
        local flutter_tools = require('flutter-tools')
        flutter_tools.setup({
            lsp = {
                on_attach = on_attach.lsp_attach,
            },
        })
    end,
}
