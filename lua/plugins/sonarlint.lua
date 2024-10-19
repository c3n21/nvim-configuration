local sonarlint = {}
local install_root_dir = vim.fn.stdpath('data') .. '/mason'

--- @type string
local pathToNodeExecutable = vim.fn.exepath('node')

if type(pathToNodeExecutable) ~= 'string' or pathToNodeExecutable == '' then
    vim.notify(string.format("pathToNodeExecutable '%s' is not valid", pathToNodeExecutable), vim.log.levels.WARN, {
        stuff = pathToNodeExecutable,
    })
else
    sonarlint.pathToNodeExecutable = pathToNodeExecutable
end

require('sonarlint').setup({
    server = {
        cmd = {
            -- vim.fn.expand('$MASON/bin/sonarlint-language-server'),
            'sonarlint-language-server',
            -- Ensure that sonarlint-language-server uses stdio channel
            '-stdio',
            '-analyzers',
            -- paths to the analyzers you need, using those for python and java in this example
            install_root_dir .. '/share/sonarlint-analyzers/sonarpython.jar',
            install_root_dir .. '/share/sonarlint-analyzers/sonarcfamily.jar',
            install_root_dir .. '/share/sonarlint-analyzers/sonarjava.jar',
            install_root_dir .. '/share/sonarlint-analyzers/sonarjs.jar',
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
