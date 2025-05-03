local mappings_enum = require('mappings')
---
---@param client vim.lsp.Client
---@param bufnr number
return function(client, bufnr)
    local fzf_lua = require('fzf-lua')

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
