vim.g.coq_settings = { ["keymap.recommended"] = true }

vim.api.nvim_set_keymap('i','<Esc>',
	[[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap('i','<C-c>',
	[[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap('i','<BS>',
	[[pumvisible() ? "\<C-e><BS>"  : "\<BS>"]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap('i','<CR>',
	[[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap('i','<CR>',
	[[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap('i','<Tab>',
	[[pumvisible() ? "\<C-n>" : "\<Tab>"]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap('i','<S-Tab>',
	[[pumvisible() ? "\<C-p>" : "\<BS>"]],
	{ noremap = true, silent = true }
)
