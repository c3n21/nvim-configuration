require('hop').setup()

-- place this in one of your configuration file(s)
vim.api.nvim_set_keymap(
    '',
    '<leader>f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    ,
    {}
)
vim.api.nvim_set_keymap(
    '',
    '<leader>F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    ,
    {}
)
vim.api.nvim_set_keymap(
    '',
    '<leader>t',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
    ,
    {}
)
vim.api.nvim_set_keymap(
    '',
    '<leader>T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
    ,
    {}
)

vim.keymap.set({ 'n' }, '<leader>/', ':HopPattern<cr>', { noremap = true, silent = true })

vim.keymap.set({ 'n' }, '<leader>w', ':HopWord<cr>', { noremap = true, silent = true })
