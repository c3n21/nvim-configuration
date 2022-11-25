local opts = { noremap = true, silent = true }

-- Generic
vim.keymap.set({ 'x' }, '<M-K>', ':m-2 <CR>gv=gv', opts)
vim.keymap.set({ 'n' }, '<M-K>', ':<C-u>m-2<CR>==', opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m-2<CR>==', opts)
vim.keymap.set({ 'x' }, '<M-J>', ":m'>+<CR>gv=gv", opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m+<CR>==', opts)
vim.keymap.set({ 'n' }, '<leader>bq', ':bd<CR>', opts)
vim.keymap.set({ 'n' }, '<leader>lq', ':lclose<CR>', opts)
vim.keymap.set({ 'n' }, ']l', ':lnext<CR>', opts)
vim.keymap.set({ 'n' }, '[l', ':lprev<CR>', opts)
vim.keymap.set({ 'n' }, '<leader>qq', ':cclose<CR>', opts)
vim.keymap.set({ 'n' }, ']q', ':cnext <CR>', opts)
vim.keymap.set({ 'n' }, '[q', ':cprevious <CR>', opts)
vim.keymap.set({ 'n' }, '<leader>tn', ':tabe %<CR>', opts)
vim.keymap.set({ 'n' }, '<leader><leader>i', ':luafile ' .. os.getenv('MYVIMRC') .. '<CR>', opts)

-- LSP
vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set({ 'n' }, 'gD', vim.lsp.buf.type_definition, opts)
vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
vim.keymap.set({ 'n' }, 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
vim.keymap.set({ 'n' }, '<leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set({ 'n' }, '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set({ 'n' }, '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set({ 'n' }, ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set({ 'n' }, '<leader>q', vim.diagnostic.setloclist, opts)
vim.keymap.set({ 'n' }, '<leader><leader>f', vim.lsp.buf.format, opts)

for _, breakpoint in ipairs({ ',', '.', '[', ']', '!', '?' }) do
    vim.keymap.set({ 'i' }, breakpoint, breakpoint .. '<c-g>u', opts)
end
