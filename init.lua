local fmt = string.format

local success, _ = pcall(require, 'settings')
if not success then
    vim.notify(fmt('Error loading settings: %s', vim.inspect(success)), vim.log.levels.WARN)
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

require('mappings')
