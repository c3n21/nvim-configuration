--- @type LazyPlugin
return {
    'stevearc/conform.nvim',
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
            nix = { 'nixpkgs-fmt' },
        },
        format_on_save = function(bufnr)
            local ts = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
            -- Disable autoformat on certain filetypes
            local ignore_filetypes = {}

            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
            end

            if vim.tbl_contains(ts, vim.bo[bufnr].filetype) then
                vim.cmd('TSToolsOrganizeImports sync')
                vim.cmd('TSToolsAddMissingImports sync')
            end
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match('/node_modules/') then
                return
            end
            -- ...additional logic...
            return { timeout_ms = 500, lsp_fallback = true }
        end,
        -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        log_level = vim.log.levels.ERROR,
        -- Conform will notify you when a formatter errors
        notify_on_error = false,
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        local conform = require('conform')
        vim.keymap.set({ 'n', 'i' }, '<leader><leader>f', function()
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
