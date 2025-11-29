---@class Fugit2Config
local opts = {
    width = 100,
    min_width = 50,
    content_width = 60,
    max_width = '80%',
    height = '60%',
    external_diffview = false,
    blame_priority = 1,
    blame_info_height = 10,
    blame_info_width = 60,
    show_patch = true,
    command_timeout = 15000,
}

require('fugit2').setup(opts)

vim.keymap.set('n', require('mappings')['GitUI'], '<cmd>Fugit2<CR>', { desc = 'Fugit2: Open Fugitive' })
