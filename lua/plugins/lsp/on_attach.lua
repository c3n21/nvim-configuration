local navic = require('nvim-navic')
local mappings_enum = require('mappings')
local map_opts = { noremap = true, silent = true }
-- TODO:
-- write a wrapper that allocates the right mappings based on client's capabilities

local function format(opts)
    opts = opts or {}
    local get_formatter = require('plugins.lsp.get_formatter')
    local format_client = get_formatter() or {}

    if not opts.filter and not vim.tbl_isempty(format_client) then
        -- extend opts with a table with filter function
        opts.filter = function(client)
            return client.name == format_client.name
        end
    end

    vim.lsp.buf.format(opts)
end

local function lazy_format(bufnr)
    local has_changed = vim.fn.getbufinfo(vim.fn.bufname(bufnr))[1]['changed'] == 1

    if has_changed then
        format({ bufnr = bufnr })
    else
        print("Not formatting since it hasn't changed")
    end
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local function format_attach(client, bufnr)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lazy_format(bufnr)
            end,
        })
    end
    vim.keymap.set({ 'n' }, '<leader><leader>f', format, map_opts)
end

local function lsp_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    local builtin = require('telescope.builtin')

    vim.keymap.set({ 'n' }, 'gr', builtin.lsp_references, map_opts)
    vim.keymap.set({ 'n' }, '<leader>ldd', builtin.diagnostics, map_opts)
    --TODO: use these again
    --[[ vim.keymap.set({ 'n' }, '<leader>ld', builtin.lsp_document_symbols, opts) ]]
    --[[ vim.keymap.set({ 'n' }, '<leader>lw', builtin.lsp_workspace_symbols, opts) ]]

    -- LSP
    vim.keymap.set({ 'n', 'i' }, '<C>]', function()
        builtin.lsp_definitions({
            {
                reuse_win = true,
            },
        })
    end, map_opts)
    vim.keymap.set({ 'n' }, 'gD', builtin.lsp_type_definitions, map_opts)
    -- Check hover plugin
    vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, map_opts)
    vim.keymap.set({ 'n' }, 'gi', builtin.lsp_implementations, map_opts)
    vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.declaration, map_opts)
    vim.keymap.set(
        { 'n' },
        mappings_enum['GoToDefinitionTab'],
        '<cmd>tab split | lua vim.lsp.buf.definition()<CR> ',
        map_opts
    )
    vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, map_opts)
    --[[ vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts) ]]
    vim.keymap.set('n', '<leader>rn', function()
        return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { expr = true })
    vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, map_opts)
    vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, map_opts)
end

return {
    lsp_attach = lsp_attach,
    format_attach = format_attach,
}
