local navic = require('nvim-navic')

navic.setup({
    icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = '練',
        Interface = '練',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = '◩ ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = 'ﳠ ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
    },
    highlight = true,
    separator = ' || ',
    depth_limit = 0,
    depth_limit_indicator = '..',
    safe_output = true,
})

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    --[[ vim.keymap.set({ 'n' }, '<leader>bo', function() ]]
    --[[     require('telescope.builtin').buffers({ only_cwd = vim.fn.haslocaldir() == 1 }) ]]
    --[[ end, opts) ]]
    local builtin = require('telescope.builtin')

    vim.keymap.set({ 'n' }, 'gr', builtin.lsp_references, opts)
    vim.keymap.set({ 'n' }, '<leader>ldd', builtin.diagnostics, opts)
    --TODO: use these again
    --[[ vim.keymap.set({ 'n' }, '<leader>ld', builtin.lsp_document_symbols, opts) ]]
    --[[ vim.keymap.set({ 'n' }, '<leader>lw', builtin.lsp_workspace_symbols, opts) ]]

    -- LSP
    vim.keymap.set({ 'n', 'i' }, '<C>]', builtin.lsp_definitions, opts)
    vim.keymap.set({ 'n' }, 'gD', builtin.lsp_type_definitions, opts)
    vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set({ 'n' }, 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.declaration, opts)
    vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n' }, '<leader><leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set({ 'n' }, '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set({ 'n' }, ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set({ 'n' }, '<leader>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set({ 'n' }, '<leader><leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, opts)
end

return on_attach
