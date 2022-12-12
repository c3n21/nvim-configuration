local Hydra = require('hydra')

Hydra({
    name = 'Change / Resize Window',
    mode = { 'n' },
    body = '<C-w>',
    config = {
        -- color = "pink",
    },
    heads = {
        -- move between windows
        { '<C-h>', '<C-w>h' },
        { '<C-j>', '<C-w>j' },
        { '<C-k>', '<C-w>k' },
        { '<C-l>', '<C-w>l' },

        -- resizing window
        { 'H', '<C-w>3<' },
        { 'L', '<C-w>3>' },
        { 'K', '<C-w>2+' },
        { 'J', '<C-w>2-' },

        -- equalize window sizes
        { 'e', '<C-w>=' },

        -- close active window
        { 'Q', '<cmd>q<cr>' },
        { '<C-q>', '<cmd>q<cr>' },

        -- exit this Hydra
        { 'q', nil, { exit = true, nowait = true } },
        { ';', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true } },
    },
})

Hydra({
    name = 'rest.nvim',
    mode = { 'n' },
    body = '<leader><leader>r',
    hint = [[
 _r_        RestNvim
 _p_        RestNvimPreview
 _l_        RestNvimLast
 _<Esc>_    quit
    ]],

    config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
            position = 'middle',
            border = 'rounded',
        },
    },
    heads = {
        { 'r', '<Plug>RestNvim' },
        { 'p', '<Plug>RestNvimPreview' },
        { 'l', '<Plug>RestNvimLast' },
        { '<Esc>', nil, { exit = true, nowait = true } },
    },
})
