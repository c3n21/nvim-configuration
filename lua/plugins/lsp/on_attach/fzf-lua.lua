local mappings_enum = require('mappings')

--- @type fun(opts:vim.keymap.set.Opts)
local make_opts = (function()
    local map_opts = { noremap = true, silent = true }
    return function(opts)
        return vim.tbl_extend('keep', map_opts, opts)
    end
end)()

local fzf_lua = require('fzf-lua')

---
---@param client vim.lsp.Client
---@param bufnr number
return function(client, bufnr)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
        vim.keymap.set(
            { 'n' },
            mappings_enum['LeaderDefinition'],
            fzf_lua.lsp_definitions,
            make_opts({
                desc = 'LSP definitions',
            })
        )
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
        vim.keymap.set(
            { 'n' },
            mappings_enum['LeaderTypeDefinition'],
            fzf_lua.lsp_typedefs,
            make_opts({
                desc = 'LSP type definitions',
            })
        )
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_references) then
        vim.keymap.set(
            { 'n' },
            mappings_enum['LspReferences'],
            fzf_lua.lsp_references,
            make_opts({
                desc = 'LSP references',
            })
        )
    end
end
