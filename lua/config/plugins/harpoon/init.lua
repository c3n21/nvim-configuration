require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    },
    project = {}
})

vim.api.nvim_set_keymap(
'n','<leader>af',
'<cmd> lua require("harpoon.mark").add_file() <CR>',
{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
'n','<leader>m',
'<cmd> lua require("harpoon.ui").toggle_quick_menu() <CR>',
{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
'n','<leader>t',
'<cmd> lua require("harpoon.term").gotoTerminal(1) <CR>',
{ noremap = true, silent = true }
)
