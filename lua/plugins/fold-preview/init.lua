return {
    'anuvyklack/fold-preview.nvim',
    dependencies = {
        'anuvyklack/keymap-amend.nvim',
    },
    config = function()
        local keymap = vim.keymap
        keymap.amend = require('keymap-amend')
        local map = require('fold-preview').mapping

        keymap.amend('n', 'h', map.show_close_preview_open_fold)
        keymap.amend('n', 'l', map.close_preview_open_fold)
        keymap.amend('n', 'zo', map.close_preview)
        keymap.amend('n', 'zO', map.close_preview)
        keymap.amend('n', 'zc', map.close_preview_without_defer)
        keymap.amend('n', 'zR', map.close_preview)
        keymap.amend('n', 'zM', map.close_preview_without_defer)
    end,
}
