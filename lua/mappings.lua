local map_opts = { noremap = true, silent = true }

local mappings_enum = {
    ['FindFiles'] = '<leader>ff',
    ['SourceInit'] = '<leader><leader>i',
    ['TabNext'] = '<leader>tn',
    ['CPrev'] = '[q',
    ['CNext'] = ']q',
    ['CClose'] = '<leader>qq',
    ['COpen'] = '<leader>qo',
    ['LPrev'] = '[l',
    ['LNext'] = ']l',
    ['LClose'] = '<leader>lq',
    ['LOpen'] = '<leader>lo',
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
    ['GoToDefinitionTab'] = '<C-w><C-]>',
    ['LspReferences'] = 'gr',
    ['ToggleInlayHints'] = 'gK',
    ['Format'] = '==',
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
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<space>f', function()
        --   vim.lsp.buf.format { async = true }
        -- end, opts)

        local builtin = require('telescope.builtin')

        -- vim.keymap.set({ 'n' }, 'gr', builtin.lsp_references, map_opts)
        vim.keymap.set({ 'n' }, '<leader>ldd', builtin.diagnostics, opts)
        --TODO: use these again
        --[[ vim.keymap.set({ 'n' }, '<leader>ld', builtin.lsp_document_symbols, opts) ]]
        --[[ vim.keymap.set({ 'n' }, '<leader>lw', builtin.lsp_workspace_symbols, opts) ]]

        -- LSP
        vim.keymap.set({ 'n' }, 'gD', builtin.lsp_type_definitions, opts)
        -- Check hover plugin
        vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set({ 'n' }, 'gi', builtin.lsp_implementations, opts)
        vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.declaration, opts)
        vim.keymap.set(
            { 'n' },
            mappings_enum['GoToDefinitionTab'],
            '<cmd>tab split | lua vim.lsp.buf.definition()<CR> ',
            opts
        )
        vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
        --[[ vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts) ]]
        vim.keymap.set('n', '<leader>rn', function()
            return ':IncRename ' .. vim.fn.expand('<cword>')
        end, { expr = true })
        vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, opts)
        vim.keymap.set({ 'n' }, mappings_enum['ToggleInlayHints'], function()
            vim.lsp.inlay_hint(0, nil)
        end, opts)
    end,
})

return mappings_enum
