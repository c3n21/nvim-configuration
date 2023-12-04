local setup = function(config)
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    config['capabilities'] = capabilities
    return config
end

return setup
