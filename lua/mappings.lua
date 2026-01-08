---@type vim.keymap.set.Opts
local map_opts = { noremap = true, silent = true }

---Automatically set stuff
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
local function set(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, map_opts))
end

---@enum GlobalMappings
local mappings_enum = {
    ['CClose'] = '<leader>qq',
    ['CNext'] = ']q',
    ['COpen'] = '<M-q>',
    ['CPrev'] = '[q',
    ['CodeActions'] = 'gra',
    ['DocumentSymbol'] = 'gO',
    ['WorkspaceSymbol'] = '<leader>wgO',
    ['FindFiles'] = '<leader>ff',
    ['FindGitFiles'] = '<leader>gf',
    ['Format'] = '==',
    ['FuzzyFinder'] = '<M-/>',
    ['GoToDefinitionTab'] = '<C-w><C-]>',
    ['Grep'] = '<leader>gg',
    ['LiveGrep'] = '<leader>gl',
    ['Implementation'] = 'gri',
    ['LClose'] = '<leader>lq',
    ['LNext'] = ']l',
    ['LOpen'] = '<M-l>',
    ['LPrev'] = '[l',
    ['LspReferences'] = 'grr',
    ['Ls'] = '<leader>ls',
    ['Rename'] = 'grn',
    ['SignatureHelp'] = 'H',
    ['SourceInit'] = '<leader><leader>i',
    ['ToggleInlayHints'] = 'gK',
    ['LeaderDefinition'] = '<leader>gd',
    ['LeaderTypeDefinition'] = '<leader>gD',
    ['Hover'] = 'K',
    -- [ Git UI inside NeoVim, not the TUI client
    ['GitUI'] = '<leader>ng',
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

do
    local mode = 'n'
    local prev = -1
    local next = 1

    ---@enum DiagnosticMappings
    local diagnostic_mappings = {
        [vim.diagnostic.severity.INFO] = {
            [-1] = '<leader>[d',
            [1] = '<leader>]d',
        },
        [vim.diagnostic.severity.WARN] = {
            [-1] = '<leader>[w',
            [1] = '<leader>]w',
        },
        [vim.diagnostic.severity.ERROR] = {
            [-1] = '<leader>[e',
            [1] = '<leader>]e',
        },
    }

    local function setDiagnostics(lhs, jumpOpts)
        set(mode, lhs, function()
            vim.diagnostic.jump(jumpOpts)
        end)
    end

    for severity, mappings in pairs(diagnostic_mappings) do
        local prevJumpOpts = {
            count = prev,
            float = true,
            wrap = false,
            severity = severity,
        }

        local nextJumpOpts = {
            count = next,
            float = true,
            wrap = false,
            severity = severity,
        }

        setDiagnostics(mappings[prev], prevJumpOpts)
        setDiagnostics(mappings[next], nextJumpOpts)
    end
end

return mappings_enum
