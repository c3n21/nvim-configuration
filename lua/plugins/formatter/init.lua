--- @type LazyPlugin
return {
    'https://github.com/stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            -- Conform will run multiple formatters sequentially
            python = { 'isort', 'black' },
            -- Use a sub-list to run only the first available formatter
            javascript = { { 'prettierd', 'prettier' } },
            javascriptreact = { { 'prettierd', 'prettier' } },
            typescript = { { 'prettierd', 'prettier' } },
            typescriptreact = { { 'prettierd', 'prettier' } },
            nix = { 'alejandra' },
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            -- disable for this reason: https://github.com/neovim/neovim/issues/26520
            lsp_fallback = false,
        },
        -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        log_level = vim.log.levels.DEBUG,
        -- Conform will notify you when a formatter errors
        notify_on_error = false,
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        local conform = require('conform')
        vim.keymap.set({ 'n' }, '<leader><leader>f', function()
            conform.format({
                async = true,
            })
        end)
    end,
    config = function(_, opts)
        local conform = require('conform')
        conform.setup(opts)
    end,
}
