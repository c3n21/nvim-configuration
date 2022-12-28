-- return function that returns null-ls formatter if exists, otherwise
-- return the first formatter found otherwise nil
return function()
    local active_clients = vim.lsp.buf_get_clients(0)
    -- filter clients with document_formatting capability
    local format_clients = vim.tbl_filter(function(client)
        return client.supports_method('textDocument/formatting')
    end, active_clients)

    local null_ls_clients = vim.tbl_filter(function(client)
        return client.name == 'null-ls'
    end, format_clients)

    return null_ls_clients[1] or format_clients[1]
end
