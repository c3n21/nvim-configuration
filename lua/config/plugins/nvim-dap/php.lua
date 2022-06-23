return {
    adapters = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.glob('~/Downloads/github/vscode-php-debug/out/phpDebug.js') },
    },
    configurations = {
        {
            name = 'run current script',
            type = 'php',
            request = 'launch',
            port = 9003,
            cwd = '${fileDirname}',
            program = '${file}',
            runtimeExecutable = 'php',
        },
        {
            type = 'php',
            request = 'launch',
            name = 'Listen for Xdebug',
            port = 9003,
        },
    },
}
