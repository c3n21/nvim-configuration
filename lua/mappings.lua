---@type vim.keymap.set.Opts
local map_opts = { noremap = true, silent = true }

---Automatically set stuff
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
local function set(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('error', opts, map_opts))
end

---@enum GlobalMappings
local mappings_enum = {
    ['CClose'] = '<leader>qq',
    ['CNext'] = ']q',
    ['COpen'] = '<M-q>',
    ['CPrev'] = '[q',
    ['CodeActions'] = 'gra',
    ['DiagnosticErrorNext'] = '<leader>]e',
    ['DiagnosticErrorPrev'] = '<leader>[e',
    ['DiagnosticInfoNext'] = '<leader>]i',
    ['DiagnosticInfoPrev'] = '<leader>[i',
    ['DiagnosticNext'] = '<leader>]d',
    ['DiagnosticPrev'] = '<leader>[d',
    ['DiagnosticWarningNext'] = '<leader>]w',
    ['DiagnosticWarningPrev'] = '<leader>[w',
    ['DocumentSymbol'] = 'gO',
    ['WorkspaceSymbol'] = '<leader>wgO',
    ['FindFiles'] = '<leader>ff',
    ['FindGitFiles'] = '<leader>gf',
    ['Format'] = '==',
    ['GoToDefinitionTab'] = '<C-w><C-]>',
    ['Grep'] = '<leader>g',
    ['LiveGrep'] = '<leader>gl',
    ['Implementation'] = 'gri',
    ['LClose'] = '<leader>lq',
    ['LNext'] = ']l',
    ['LOpen'] = '<M-l>',
    ['LPrev'] = '[l',
    ['LspReferences'] = 'grr',
    ['Ls'] = '<leader>ls',
    ['OpenDiagnosticLoclist'] = '<leader>l',
    ['OpenFloatDiagnostic'] = '<leader><leader>d',
    ['Rename'] = 'grn',
    ['SignatureHelp'] = 'H',
    ['SourceInit'] = '<leader><leader>i',
    ['ToggleInlayHints'] = 'gK',
    ['LeaderDefinition'] = '<leader>gd',
    ['LeaderTypeDefinition'] = '<leader>gD',
    ['Hover'] = 'K',
}

vim.keymap.set({ 'x' }, '<M-K>', ':m-2 <CR>gv=gv', map_opts)
vim.keymap.set({ 'n' }, '<M-K>', ':<C-u>m-2<CR>==', map_opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m-2<CR>==', map_opts)
vim.keymap.set({ 'x' }, '<M-J>', ":m'>+<CR>gv=gv", map_opts)
vim.keymap.set({ 'n' }, '<M-J>', ':<C-u>m+<CR>==', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LClose'], ':lclose<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LNext'], ':lnext<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['LPrev'], ':lprev<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CClose'], ':cclose<CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CNext'], ':cnext <CR>', map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CPrev'], ':cprevious <CR>', map_opts)
-- vim.keymap.set({ 'n' }, mappings_enum['SourceInit'], ':luafile ' .. os.getenv('MYVIMRC') .. '<CR>', map_opts)
set({ 'n' }, mappings_enum['COpen'], ':copen<CR>', {
    desc = 'Open quickfix list',
})
set({ 'n' }, mappings_enum['LOpen'], ':lopen<CR>', {
    desc = 'Open location list',
})
vim.keymap.set({ 't' }, '<ESC><ESC>', '<C-\\><C-n>', map_opts)

for _, breakpoint in ipairs({ ',', '.', '[', ']', '!', '?' }) do
    vim.keymap.set({ 'i' }, breakpoint, breakpoint .. '<c-g>u', map_opts)
end

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
--         --[[ vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts) ]]
--         vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, opts)
--         vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, opts)
--     end,
-- })

vim.keymap.set('n', mappings_enum['DiagnosticPrev'], vim.diagnostic.goto_prev)
vim.keymap.set('n', mappings_enum['DiagnosticNext'], vim.diagnostic.goto_next)
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

return mappings_enum
