local lspconfig = require('lspconfig')
local config = require('settings').get_config()
local completion = require('settings').completion

local language_servers = config.enable_lsp

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format('config.plugins.nvim-lspconfig.%s', language_server))
    ls_config = completion(ls_config)
    lspconfig[language_server].setup(ls_config)
end

local opts = { noremap = true, silent = true }
vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set({ 'n' }, 'gD', vim.lsp.buf.type_definition, opts)
vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
vim.keymap.set({ 'n' }, 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
vim.keymap.set({ 'n' }, '<leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set({ 'n' }, '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set({ 'n' }, '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set({ 'n' }, ']d', vim.diagnostic.goto_prev, opts)
vim.keymap.set({ 'n' }, '<leader>q', vim.diagnostic.setloclist, opts)
vim.keymap.set({ 'n' }, '<leader><leader>f', vim.lsp.buf.format, opts)

