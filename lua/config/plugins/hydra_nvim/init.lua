local Hydra = require('hydra')

local function cmd(command)
    return table.concat({ '<Cmd>', command, '<CR>' })
end

Hydra({
    name = 'Telescope',
    hint = [[
_f_: files       _m_: marks
_o_: old files   _g_: live grep
_p_: projects    _/_: search in file

_h_: vim help    _c_: execute command
_k_: keymap      _;_: commands history
_r_: registers   _?_: search history

_<Enter>_: Telescope           _<Esc>_ 
]],
    config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
            position = 'middle',
            border = 'rounded',
        },
    },
    mode = 'n',
    body = '<Leader>f',
    heads = {
        { 'f', cmd('Telescope find_files') },
        { 'g', cmd('Telescope live_grep') },
        { 'h', cmd('Telescope help_tags'), { desc = 'Vim help' } },
        { 'o', cmd('Telescope oldfiles'), { desc = 'Recently opened files' } },
        { 'm', cmd('MarksListBuf'), { desc = 'Marks' } },
        { 'k', cmd('Telescope keymaps') },
        { 'r', cmd('Telescope registers') },
        { 'p', cmd('Telescope projects'), { desc = 'Projects' } },
        { '/', cmd('Telescope current_buffer_fuzzy_find'), { desc = 'Search in file' } },
        { '?', cmd('Telescope search_history'), { desc = 'Search history' } },
        { ';', cmd('Telescope command_history'), { desc = 'Command-line history' } },
        { 'c', cmd('Telescope commands'), { desc = 'Execute command' } },
        { '<Enter>', cmd('Telescope'), { exit = true, desc = 'List all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
    },
})

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
        { 'e', '<cmd>Neotree reveal<CR>' },
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
