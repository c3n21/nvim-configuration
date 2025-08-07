local dap = require('dap')

-- DAP key mappings
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<F8>', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'DAP: Set Conditional Breakpoint' })
vim.keymap.set('n', '<F3>', function()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = 'DAP: Set Logpoint' })
vim.keymap.set('n', '<F4>', dap.repl.open, { desc = 'DAP: Open REPL' })
vim.keymap.set('n', '<F5>', function()
    dap.continue()
end, { desc = 'DAP: Continue' })
-- vim.keymap.set('n', '<F7>', function()
--     vim.schedule(require('dapui').toggle)
-- end, { desc = 'DAP UI: Toggle' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })

-- ['<F1>'] = {
--     [require('dap').toggle_breakpoint] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F2>'] = {
--     [function()
--         require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
--     end] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F3>'] = {
--     [function()
--         require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
--     end] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F4>'] = {
--     [require('dap').repl.open] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F5>'] = {
--     [function()
--         vim.schedule(require('dap').continue)
--     end] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F6>'] = {
--     [require('dap').run_last] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F7>'] = {
--     [function()
--         vim.schedule(require('dapui').toggle)
--     end] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F10>'] = {
--     [require('dap').step_over] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F11>'] = {
--     [require('dap').step_into] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
-- ['<F12>'] = {
--     [require('dap').step_out] = {
--         modes = { 'n' },
--         opts = { expr = true },
--     },
-- },
