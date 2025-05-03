local lsp_definition_opts = { jump_type = 'split', show_line = false, reuse_win = true }
local mappings_enum = require('mappings')
local map_opts = { noremap = true, silent = true }

---
---@param client vim.lsp.Client
---@param bufnr number
return function(client, bufnr)
    local builtin = require('telescope.builtin')
    -- if client.server_capabilities.definitionProvider then
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
        -- vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', {
        --     buf = bufnr,
        -- })
        vim.keymap.set({ 'n' }, mappings_enum['LeaderDefinition'], function()
            builtin.lsp_definitions(lsp_definition_opts)
        end, map_opts)
    end

    -- if client.server_capabilities.typeDefinitionProvider then
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
        vim.keymap.set({ 'n' }, mappings_enum['LeaderTypeDefinition'], function()
            builtin.lsp_type_definitions(lsp_definition_opts)
        end, map_opts)
    end

    -- if client.server_capabilities.referencesProvider then
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_references) then
        vim.keymap.set({ 'n' }, mappings_enum['LspReferences'], function()
            builtin.lsp_references({
                jump_type = 'split',
                show_line = false,
            })
        end, map_opts)
    end
end
