local mappings_enum = require('mappings')

--- @type fun(opts:vim.keymap.set.Opts)
local make_opts = (function()
    local map_opts = { noremap = true, silent = true }
    return function(opts)
        return vim.tbl_extend('keep', map_opts, opts)
    end
end)()

local fzf_lua = require('fzf-lua')

vim.keymap.set(
    { 'n' },
    mappings_enum['FindFiles'],
    fzf_lua.files,
    make_opts({
        desc = 'Find files',
    })
)

vim.keymap.set(
    { 'n' },
    mappings_enum['DocumentSymbol'],
    fzf_lua.lsp_document_symbols,
    make_opts({
        desc = 'Document symbols',
    })
)

vim.keymap.set(
    { 'n' },
    mappings_enum['CodeActions'],
    fzf_lua.lsp_code_actions,
    make_opts({
        desc = 'Code actions',
    })
)

vim.keymap.set(
    { 'n' },
    mappings_enum['Grep'],
    fzf_lua.grep,
    make_opts({
        desc = 'Grep',
    })
)

vim.keymap.set(
    { 'n' },
    mappings_enum['LiveGrep'],
    fzf_lua.live_grep_native,
    make_opts({
        desc = 'Live grep',
    })
)

vim.keymap.set(
    { 'n' },
    mappings_enum['Ls'],
    fzf_lua.buffers,
    make_opts({
        desc = 'List buffers',
    })
)

vim.keymap.set(
    { 'n' },
    mappings_enum['FindGitFiles'],
    fzf_lua.git_files,
    make_opts({
        desc = 'Find Git files',
    })
)

-- vim.keymap.set({ 'n', 'v', 'i' }, '<C-x><C-f>', function()
--     require('fzf-lua').complete_path()
-- end, { silent = true, desc = 'Fuzzy complete path' })
