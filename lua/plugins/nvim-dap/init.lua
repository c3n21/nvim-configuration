return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
        --       local settings = require('settings')
        local dap = require('dap')
        --        local _config = settings.get_config()

        --      for _, language in ipairs(_config.enable_dap) do
        --          local dap_configuration = require('plugins.nvim-dap.' .. language)
        --          for key, conf in pairs(dap_configuration) do
        --              dap[key][language] = conf
        --          end
        --      end

        --        ['<F1>'] = {
        --            [require('dap').toggle_breakpoint] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F2>'] = {
        --            [function()
        --                require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        --            end] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F3>'] = {
        --            [function()
        --                require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        --            end] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F4>'] = {
        --            [require('dap').repl.open] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F5>'] = {
        --            [function()
        --                vim.schedule(require('dap').continue)
        --            end] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F6>'] = {
        --            [require('dap').run_last] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F7>'] = {
        --            [function()
        --                vim.schedule(require('dapui').toggle)
        --            end] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F10>'] = {
        --            [require('dap').step_over] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F11>'] = {
        --            [require('dap').step_into] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
        --        ['<F12>'] = {
        --            [require('dap').step_out] = {
        --                modes = { 'n' },
        --                opts = { expr = true },
        --            },
        --        },
    end,
}
