local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- TODO: configure this inside nixCats
local clientNodePath = vim.fn.exepath('node')

if type(clientNodePath) ~= 'string' or clientNodePath == '' then
    vim.notify(string.format("clientNodePath '%s' is not valid", clientNodePath), vim.log.levels.WARN)
end

local sonarlint = {
    rules = {
        ['typescript:S101'] = { level = 'on', parameters = { format = '^[A-Z][a-zA-Z0-9]*$' } },
        ['typescript:S103'] = { level = 'on', parameters = { maximumLineLength = 180 } },
        ['typescript:S106'] = { level = 'on' },
        ['typescript:S107'] = { level = 'on', parameters = { maximumFunctionParameters = 7 } },
    },
}

require('sonarlint').setup({
    server = {
        init_options = {
            clientNodePath = clientNodePath,
        },
        capabilities = capabilities,
        cmd = {
            'sonarlint-ls',
            '-stdio',
        },
        settings = {
            sonarlint = sonarlint,
        },
    },
    filetypes = {
        'cs',
        'python',
        'cpp',
        'typescriptreact',
        'typescript',
        'javascript',

        -- Requires nvim-jdtls, otherwise an error message will be printed
        'java',
    },
})
