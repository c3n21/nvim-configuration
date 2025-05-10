vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
require('auto-session').setup({
    auto_restore = true,
    auto_restore_last_session = false,
    auto_save = true,
    bypass_save_filetypes = {
        'dashboard',
        'NvimTree',
        'packer',
        'startify',
        'fugitiveblame',
        'gitrebase',
        'gitcommit',
        'neo-tree',
        'NeogitConsole',
    },
    enabled = true,
    git_use_branch_name = true,
    log_level = 'info',
    root_dir = '~/.local/share/nvim/sessions/',
})
