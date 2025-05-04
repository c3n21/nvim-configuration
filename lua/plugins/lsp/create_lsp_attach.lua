local map_opts = { noremap = true, silent = true }
local mappings_enum = require('mappings')

-- @todo telescope needs to be set up before attaching to lsp

--- Same signature as vim.keymap.set
--- This deletes the given keymap before setting it
---@param mode string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
local function set_keymap_after_clear(mode, lhs, rhs, opts)
    vim.keymap.del(mode, lhs)
    vim.keymap.set(mode, lhs, rhs, opts)
end

--- @alias FuzzyFinders 'telescope' | 'fzf-lua'

--- Factory for on_attach function with given provider
--- @param fuzzy_finder FuzzyFinders
--- @return fun(client: vim.lsp.Client, bufnr: number)
return function(fuzzy_finder)
    --- @type fun(client: vim.lsp.Client, bufnr: number)
    local fuzzy_finder_on_attach = require('plugins.lsp.on_attach.' .. fuzzy_finder)
    return function(client, bufnr)
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = bufnr })
                end,
            })
        end

        -- if client.server_capabilities.hoverProvider then
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
            vim.keymap.set({ 'n' }, mappings_enum['Hover'], vim.lsp.buf.hover, map_opts)
        end

        -- if client.server_capabilities.signatureHelpProvider then
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
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

        -- vim.keymap.set('n', mappings_enum['Rename'], function()
        --     return ':IncRename ' .. vim.fn.expand('<cword>')
        -- end, { expr = true })

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            if not vim.lsp.inlay_hint.is_enabled() then
                vim.lsp.inlay_hint.enable(true)
            end
            vim.keymap.set({ 'n' }, mappings_enum['ToggleInlayHints'], function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, map_opts)
        end

        fuzzy_finder_on_attach(client, bufnr)
    end
end
