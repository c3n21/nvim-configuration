require('fugit2').setup()

vim.keymap.set('n', require('mappings')['GitUI'], '<cmd>Fugit2<CR>', { desc = 'Fugit2: Open Fugitive' })
