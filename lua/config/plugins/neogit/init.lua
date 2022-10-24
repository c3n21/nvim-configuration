local neogit = require('neogit')

neogit.setup {}

vim.keymap.set({ 'n' }, '<leader>ng', ':Neogit <CR>', { noremap = true, silent = true })
