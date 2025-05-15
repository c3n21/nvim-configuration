local fmt = string.format
local mappings = require('mappings')

vim.lsp.config('*', {
    on_attach = function(client, bufnr)
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
            vim.keymap.set('n', mappings['Hover'], vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
        end
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
    end,
})

local success, _ = pcall(require, 'settings')
if not success then
    vim.notify(fmt('Error loading settings: %s', vim.inspect(success)), vim.log.levels.WARN)
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Create an autocommand group to manage the autocommands
local inlay_hints_augroup = vim.api.nvim_create_augroup('ToggleInlayHints', { clear = true })

-- Disable inlay hints when entering Insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
    group = inlay_hints_augroup,
    callback = function()
        vim.lsp.inlay_hint.enable(false)
    end,
})
