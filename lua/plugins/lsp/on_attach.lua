local navic = require('nvim-navic')

local function format(opts)
    opts = opts or {}
    local get_formatter = require('plugins.lsp.get_formatter')
    local format_client = get_formatter() or {}
    print(format_client.name)

    if not opts.filter and not vim.tbl_isempty(format_client) then
        -- extend opts with a table with filter function
        opts.filter = function(client)
            return client.name == format_client.name
        end
    end

    vim.lsp.buf.format(opts)
end

local lsp_formatting = function(bufnr)
    local has_changed = vim.fn.getbufinfo(vim.fn.bufname(bufnr))[1]['changed'] == 1

    if has_changed then
        format({ bufnr = bufnr })
    else
        print("Not formatting since it hasn't changed")
    end
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end

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
    -- Check hover plugin
    vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set({ 'n' }, 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.declaration, opts)
    vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
    --[[ vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts) ]]
    vim.keymap.set('n', '<leader>rn', function()
        return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { expr = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n' }, '<leader><leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set({ 'n' }, '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set({ 'n' }, ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set({ 'n' }, '<leader>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set({ 'n' }, '<leader><leader>f', format, opts)
    vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, opts)
end

return on_attach
