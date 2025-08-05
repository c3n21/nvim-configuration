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
    clientNodePath = clientNodePath,
}

-- TODO: configure this inside nixCats
local sonarlint_path = vim.fn.exepath('sonarlint-ls')
local analizers_base_path = vim.fs.joinpath(vim.fn.fnamemodify(sonarlint_path, ':h:h'), 'share/plugins/*')

require('sonarlint').setup({
    server = {
        init_options = {
            clientNodePath = clientNodePath,
        },
        capabilities = capabilities,
        cmd = {
            sonarlint_path,
            '-stdio',
            '-analyzers',
            unpack(vim.fn.glob(analizers_base_path, true, true)),
        },
        settings = {
            sonarlint = sonarlint,
        },
    },
    filetypes = {
        -- Tested and working
        'python',
        'cpp',
        'typescriptreact',
        'typescript',
        -- Requires nvim-jdtls, otherwise an error message will be printed
        'java',
    },
})
