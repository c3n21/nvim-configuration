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
    ['CodeActions'] = 'gra',
    ['DocumentSymbol'] = 'gO',
    ['DiffViewToggle'] = '<leader>dvv',
    ['DiffViewFileHistoryToggle'] = '<leader>dvh',
    ['DiffViewCurrentFileHistoryToggle'] = '<leader>dvf',
    ['WorkspaceSymbol'] = '<leader>wgO',
    ['FindFiles'] = '<leader>ff',
    ['FindGitFiles'] = '<leader>gf',
    ['GitStatus'] = '<leader>gs',
    ['Format'] = '==',
    ['FuzzyFinder'] = '<M-/>',
    ['GoToDefinitionTab'] = '<C-w><C-]>',
    ['Grep'] = '<leader>gg',
    ['LiveGrep'] = '<leader>gl',
    ['Implementation'] = 'gri',
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
vim.keymap.set({ 't' }, '<ESC><ESC>', '<C-\\><C-n>', map_opts)

vim.keymap.set({ 'n' }, '<leader>bd', ':bd <CR>', map_opts)

for _, breakpoint in ipairs({ ',', '.', '[', ']', '!', '?' }) do
    vim.keymap.set({ 'i' }, breakpoint, breakpoint .. '<c-g>u', map_opts)
end

--- Set diagnostic keymap
do
    local mode = 'n'
    local prev = -1
    local next = 1

    ---@enum DiagnosticMappings
    local diagnostic_mappings = {
        [vim.diagnostic.severity.HINT] = {
            [-1] = '<leader>[h',
            [1] = '<leader>]h',
        },

        [vim.diagnostic.severity.INFO] = {
            [-1] = '<leader>[i',
            [1] = '<leader>]i',
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
