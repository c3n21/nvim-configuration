return {
    'https://gitlab.com/schrieveslaach/sonarlint.nvim',
    dependencies = {
        'lsp',
    },
    config = function()
        local install_root_dir = vim.fn.stdpath('data') .. '/mason'
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
    end,
}
