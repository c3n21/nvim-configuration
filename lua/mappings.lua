local map_opts = { noremap = true, silent = true }

---@enum GlobalMappings
local mappings_enum = {
    ['BufferClose'] = '<leader>bq',
    ['CClose'] = '<leader>qq',
    ['CNext'] = ']q',
    ['COpen'] = '<leader>qo',
    ['CPrev'] = '[q',
    ['CodeActions'] = '<leader>ca',
    ['DiagnosticErrorNext'] = '<leader>]e',
    ['DiagnosticErrorPrev'] = '<leader>[e',
    ['DiagnosticInfoNext'] = '<leader>]i',
    ['DiagnosticInfoPrev'] = '<leader>[i',
    ['DiagnosticNext'] = '<leader>]d',
    ['DiagnosticPrev'] = '<leader>[d',
    ['DiagnosticWarningNext'] = '<leader>]w',
    ['DiagnosticWarningPrev'] = '<leader>[w',
    ['FindFiles'] = '<leader>ff',
    ['Format'] = '==',
    ['GoToDefinitionTab'] = '<C-w><C-]>',
    ['LClose'] = '<leader>lq',
    ['LNext'] = ']l',
    ['LOpen'] = '<leader>lo',
    ['LPrev'] = '[l',
    ['LspReferences'] = 'gr',
    ['OpenDiagnosticLoclist'] = '<leader>q',
    ['OpenFloatDiagnostic'] = '<leader><leader>d',
    ['Rename'] = '<leader>rn',
    ['SourceInit'] = '<leader><leader>i',
    ['TabNext'] = '<leader>tn',
    ['ToggleInlayHints'] = 'gK',
}

-- Generic
-- vim.keymap.set({ 'n', 'i' }, '<C-]>', function()
--     local cword = vim.fn.expand('<cword>')
--     print(cword)
--     local tags = vim.lsp.tagfunc(cword, 'cr')
--     print(vim.inspect(tags))
--     -- builtin.lsp_definitions({
--     --     {
--     --         reuse_win = true,
--     --     },
--     -- })
-- end, opts)

vim.keymap.set({ 'n' }, mappings_enum['LspReferences'], vim.lsp.buf.references, map_opts)
vim.keymap.set({ 'x' }, '<M-K>', ':m-2 <CR>gv=gv', map_opts)
vim.keymap.set({ 'n' }, '<M-K>', ':<C-u>m-2<CR>==', map_opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m-2<CR>==', map_opts)
vim.keymap.set({ 'x' }, '<M-J>', ":m'>+<CR>gv=gv", map_opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m+<CR>==', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['BufferClose'], ':bd<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LClose'], ':lclose<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LNext'], ':lnext<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LPrev'], ':lprev<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CClose'], ':cclose<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CNext'], ':cnext <CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CPrev'], ':cprevious <CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['TabNext'], ':tabe %<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['SourceInit'], ':luafile ' .. os.getenv('MYVIMRC') .. '<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['COpen'], ':copen<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LOpen'], ':lopen<CR>', map_opts)

for _, breakpoint in ipairs({ ',', '.', '[', ']', '!', '?' }) do
    vim.keymap.set({ 'i' }, breakpoint, breakpoint .. '<c-g>u', map_opts)
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', mappings_enum['DiagnosticPrev'], vim.diagnostic.goto_prev)
vim.keymap.set('n', mappings_enum['DiagnosticNext'], vim.diagnostic.goto_next)
vim.keymap.set({ 'n', 'v' }, mappings_enum['CodeActions'], vim.lsp.buf.code_action, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['OpenFloatDiagnostic'], vim.diagnostic.open_float, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DiagnosticInfoPrev'], function()
    vim.diagnostic.goto_prev({ wrap = false, severity = { max = vim.diagnostic.severity.INFO } })
end, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DiagnosticInfoNext'], function()
    vim.diagnostic.goto_next({ wrap = false, severity = { max = vim.diagnostic.severity.INFO } })
end, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DiagnosticWarningPrev'], function()
    vim.diagnostic.goto_prev({ wrap = false, severity = vim.diagnostic.severity.WARN })
end, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DiagnosticWarningNext'], function()
    vim.diagnostic.goto_next({ wrap = false, severity = vim.diagnostic.severity.WARN })
end, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DiagnosticErrorPrev'], function()
    vim.diagnostic.goto_prev({ wrap = false, severity = vim.diagnostic.severity.ERROR })
end, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DiagnosticErrorNext'], function()
    vim.diagnostic.goto_next({ wrap = false, severity = vim.diagnostic.severity.ERROR })
end, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['OpenDiagnosticLoclist'], vim.diagnostic.setloclist, map_opts)
vim.keymap.set('n', mappings_enum['Rename'], vim.lsp.buf.rename, map_opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = function(ev)
--         -- Enable completion triggered by <c-x><c-o>
--         vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         local opts = { buffer = ev.buf }
--         -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--         -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--         -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--         -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--         -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--         -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--         -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--         -- vim.keymap.set('n', '<space>wl', function()
--         --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         -- end, opts)
--         -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--         -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--         -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--         -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--         -- vim.keymap.set('n', '<space>f', function()
--         --   vim.lsp.buf.format { async = true }
--         -- end, opts)

--         local builtin = require('telescope.builtin')

--         -- vim.keymap.set({ 'n' }, 'gr', builtin.lsp_references, map_opts)
--         vim.keymap.set({ 'n' }, '<leader>ldd', builtin.diagnostics, opts)
--         --TODO: use these again
--         --[[ vim.keymap.set({ 'n' }, '<leader>ld', builtin.lsp_document_symbols, opts) ]]
--         --[[ vim.keymap.set({ 'n' }, '<leader>lw', builtin.lsp_workspace_symbols, opts) ]]

--         -- LSP
--         vim.keymap.set({ 'n' }, 'gD', builtin.lsp_type_definitions, opts)
--         -- Check hover plugin
--         vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
--         vim.keymap.set({ 'n' }, 'gi', builtin.lsp_implementations, opts)
--         vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.declaration, opts)
--         vim.keymap.set(
--             { 'n' },
--             mappings_enum['GoToDefinitionTab'],
--             '<cmd>tab split | lua vim.lsp.buf.definition()<CR> ',
--             opts
--         )
--         vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
--         --[[ vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts) ]]
--         vim.keymap.set('n', '<leader>rn', function()
--             return ':IncRename ' .. vim.fn.expand('<cword>')
--         end, { expr = true })
--         vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, opts)
--         vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, opts)
--         vim.keymap.set({ 'n' }, mappings_enum['ToggleInlayHints'], function()
--             vim.lsp.inlay_hint(0, nil)
--         end, opts)
--     end,
-- })

return mappings_enum
