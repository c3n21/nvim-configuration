return {
    'mxsdev/nvim-dap-vscode-js',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    config = function()
        require('dap-vscode-js').setup({
            -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
            debugger_cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/js-debug-adapter') }, -- Path to vscode-js-debug installation.
            -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        })

        for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact' }) do
            require('dap').configurations[language] = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Debug Jest Tests',
                    -- trace = true, -- include debugger info
                    runtimeExecutable = 'node',
                    runtimeArgs = {
                        './node_modules/jest/bin/jest.js',
                        '--runInBand',
                    },
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    console = 'integratedTerminal',
                    internalConsoleOptions = 'neverOpen',
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Debug Mocha Tests',
                    -- trace = true, -- include debugger info
                    runtimeExecutable = 'node',
                    runtimeArgs = {
                        './node_modules/mocha/bin/mocha.js',
                    },
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    console = 'integratedTerminal',
                    internalConsoleOptions = 'neverOpen',
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                },
                {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Attach',
                    processId = require('dap.utils').pick_process,
                    cwd = '${workspaceFolder}',
                },
            }
        end
    end,
}
