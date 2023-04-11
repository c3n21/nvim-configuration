local opts = { noremap = true, silent = true }

local enum = {
    ['FindFiles'] = '<leader>ff',
    ['SourceInit'] = '<leader><leader>i',
    ['TabNext'] = '<leader>tn',
    ['CPrev'] = '[q',
    ['CNext'] = ']q',
    ['CClose'] = '<leader>qq',
    ['LPrev'] = '[l',
    ['LNext'] = ']l',
    ['LClose'] = '<leader>lq',
    ['BufferClose'] = '<leader>bq',
    ['CodeActions'] = '<leader>ca',
    ['OpenFloatDiagnostic'] = '<leader><leader>d',
    ['PrevDiagnosticInfo'] = '[d',
    ['NextDiagnosticInfo'] = ']d',
    ['PrevDiagnosticWarning'] = '[w',
    ['NextDiagnosticWarning'] = ']w',
    ['PrevDiagnosticError'] = '[e',
    ['NextDiagnosticError'] = ']e',
    ['OpenDiagnosticLoclist'] = '<leader>q',
}

-- Generic
vim.keymap.set({ 'x' }, '<M-K>', ':m-2 <CR>gv=gv', opts)
vim.keymap.set({ 'n' }, '<M-K>', ':<C-u>m-2<CR>==', opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m-2<CR>==', opts)
vim.keymap.set({ 'x' }, '<M-J>', ":m'>+<CR>gv=gv", opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m+<CR>==', opts)
vim.keymap.set({ 'n' }, enum['BufferClose'], ':bd<CR>', opts)
vim.keymap.set({ 'n' }, enum['LClose'], ':lclose<CR>', opts)
vim.keymap.set({ 'n' }, enum['LNext'], ':lnext<CR>', opts)
vim.keymap.set({ 'n' }, enum['LPrev'], ':lprev<CR>', opts)
vim.keymap.set({ 'n' }, enum['CClose'], ':cclose<CR>', opts)
vim.keymap.set({ 'n' }, enum['CPrev'], ':cnext <CR>', opts)
vim.keymap.set({ 'n' }, enum['CNext'], ':cprevious <CR>', opts)
vim.keymap.set({ 'n' }, enum['TabNext'], ':tabe %<CR>', opts)
vim.keymap.set({ 'n' }, enum['SourceInit'], ':luafile ' .. os.getenv('MYVIMRC') .. '<CR>', opts)

for _, breakpoint in ipairs({ ',', '.', '[', ']', '!', '?' }) do
    vim.keymap.set({ 'i' }, breakpoint, breakpoint .. '<c-g>u', opts)
end

return enum
