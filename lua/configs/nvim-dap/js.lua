local dap = require('dap')
-- On Nix this is a script that runs dapDebugServer
local executable = 'js-debug'

dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
        command = executable,
        args = { '${port}' },
    },
}

dap.adapters['node2'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
        command = executable,
        args = { '${port}' },
    },
}

dap.adapters['chrome'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
        command = executable,
        args = { '${port}' },
    },
}

local languages = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' }

for _, language in pairs(languages) do
    dap.configurations[language] = {
        {
            type = 'pwa-node',
            request = 'launch',
            name = '[pwa-node] Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
        },
        {
            name = '[node2] Launch',
            type = 'node2',
            request = 'launch',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = '[node2] Attach to process',
            type = 'node2',
            request = 'attach',
            processId = require('dap.utils').pick_process,
        },
        {
            type = 'pwa-node',
            request = 'launch',
            name = '[pwa-node] [deno] Launch file',
            runtimeExecutable = 'deno',
            runtimeArgs = {
                'run',
                '--inspect-wait',
                '--allow-all',
            },
            program = '${file}',
            cwd = '${workspaceFolder}',
            attachSimplePort = 9229,
        },
        {
            type = 'chrome',
            name = '[chrome] Launch Chrome',
            request = 'attach',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            port = 9222,
            webRoot = '${workspaceFolder}',
        },
    }
end
