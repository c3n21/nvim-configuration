return {
    'akinsho/flutter-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local flutter_tools = require('flutter-tools')
        flutter_tools.setup({
            experimental = {
                lsp_derive_paths = true,
            },
        })
    end,
}
