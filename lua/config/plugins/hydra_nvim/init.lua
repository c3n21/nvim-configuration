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
    name = 'Neotree',
    mode = { 'n' },
    body = '<leader>e',
    hint = [[
 _f_        Neotree float  
 _e_        Neotree reveal  
 _q_        Neotree close  
 _l_        Neotree right  
 _h_        Neotree left  
 _k_        Neotree top  
 _j_        Neotree bottom  
 _gs_       Neotree git_status  
 _b_        Neotree buffers  
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
        { 'f', '<cmd>Neotree float<CR>' },
        { 'e', '<cmd>Neotree toggle<CR>' },
        { 'r', '<cmd>Neotree reveal<CR>' },
        { 'q', '<cmd>Neotree close<CR>' },
        { 'l', '<cmd>Neotree right<CR>' },
        { 'h', '<cmd>Neotree left<CR>' },
        { 'k', '<cmd>Neotree top<CR>' },
        { 'j', '<cmd>Neotree bottom<CR>' },
        { 'gs', '<cmd>Neotree git_status<CR>' },
        { 'b', '<cmd>Neotree buffers<CR>' },
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
