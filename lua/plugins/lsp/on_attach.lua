local navic = require('nvim-navic')
local mappings = require('mappings')
local map_opts = { noremap = true, silent = true }

local lsp_definition_opts = {
    jump_type = 'split',
    show_line = false,
    reuse_win = true,
}
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
    vim.keymap.set({ 'n' }, mappings['Format'], format, map_opts)
end

local mappings_enum = require('mappings')

---@param client lsp.Client
---@param bufnr number
local function lsp_attach(client, bufnr)
    local builtin = require('telescope.builtin')
    if client.server_capabilities.definitionProvider then
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
        vim.keymap.set({ 'n' }, mappings_enum['LeaderDefinition'], function()
            builtin.lsp_definitions(lsp_definition_opts)
        end, map_opts)
    end

    if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set({ 'n' }, mappings_enum['LeaderTypeDefinition'], function()
            builtin.lsp_type_definitions(lsp_definition_opts)
        end, map_opts)
    end

    if client.server_capabilities.referencesProvider then
        vim.keymap.set({ 'n' }, mappings_enum['LspReferences'], function()
            builtin.lsp_references({
                jump_type = 'split',
                show_line = false,
            })
        end, map_opts)
    end

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    if client.server_capabilities.hoverProvider then
        vim.keymap.set({ 'n' }, mappings_enum['Hover'], vim.lsp.buf.hover, map_opts)
    end

    if client.server_capabilities.signatureHelpProvider then
        vim.keymap.set({ 'n' }, mappings_enum['SignatureHelp'], vim.lsp.buf.signature_help, map_opts)
    end

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
    vim.keymap.set('n', mappings_enum['Rename'], function()
        return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { expr = true })
    vim.keymap.set({ 'n' }, mappings_enum['ToggleInlayHints'], function()
        vim.lsp.inlay_hint(0, nil)
    end, map_opts)
end

return {
    lsp_attach = lsp_attach,
    format_attach = format_attach,
}
