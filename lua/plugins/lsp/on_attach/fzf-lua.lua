local mappings_enum = require('mappings')
local map_opts = { noremap = true, silent = true }

local fzf_lua = require('fzf-lua')

vim.keymap.set({ 'n' }, mappings_enum['FindFiles'], fzf_lua.files, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['DocumentSymbol'], fzf_lua.lsp_document_symbols, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['CodeActions'], fzf_lua.lsp_code_actions, map_opts)
vim.keymap.set({ 'n' }, mappings_enum['Ls'], fzf_lua.buffers, map_opts)
-- vim.keymap.set({ 'n', 'v', 'i' }, '<C-x><C-f>', function()
--     require('fzf-lua').complete_path()
-- end, { silent = true, desc = 'Fuzzy complete path' })

---
---@param client vim.lsp.Client
---@param bufnr number
return function(client, bufnr)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
        vim.keymap.set({ 'n' }, mappings_enum['LeaderDefinition'], fzf_lua.lsp_definitions, map_opts)
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
        vim.keymap.set({ 'n' }, mappings_enum['LeaderTypeDefinition'], fzf_lua.lsp_typedefs, map_opts)
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_references) then
        vim.keymap.set({ 'n' }, mappings_enum['LspReferences'], fzf_lua.lsp_references, map_opts)
    end
end
