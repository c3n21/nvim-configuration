return {
    adapters = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.glob('~/Downloads/github/vscode-php-debug/out/phpDebug.js') },
    },
    configurations = {
        {
            name = 'Run current script VSCode',
            type = 'php',
            request = 'launch',
            port = 9003,
            hostname = '0.0.0.0',
            pathMappings = {
                ['/var/www/html'] = '${workspaceFolder}',
            },
        },
        {
            name = 'Run current script (Native)',
            type = 'php',
            request = 'launch',
            port = 9003,
            cwd = '${fileDirname}',
            program = '${file}',
            runtimeExecutable = 'php',
        },
    },
}
