local opts = { noremap = true, silent = true }
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

for _, breakpoint in ipairs({ ',', '.', '[', ']', '!', '?' }) do
  vim.keymap.set({ 'i' }, breakpoint, breakpoint .. '<c-g>u', opts)
end
