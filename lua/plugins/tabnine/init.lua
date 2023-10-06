local tabnine_log_path = vim.fn.stdpath('cache') .. '/tabnine.log'

return {
    'codota/tabnine-nvim',
    name = 'tabnine',
    build = './dl_binaries.sh',
    opts = {
        disable_auto_comment = true,
        accept_keymap = '<M-l>',
        dismiss_keymap = '<C-e>',
        debounce_ms = 800,
        suggestion_color = { gui = '#808080', cterm = 244 },
        exclude_filetypes = { 'TelescopePrompt' },
        log_file_path = tabnine_log_path,
    },
}
