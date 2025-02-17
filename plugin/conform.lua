---@type conform.setupOpts['formatters_by_ft']
local formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    python = { 'isort', 'black' },
    php = { 'php_cs_fixer' },
    -- Use a sub-list to run only the first available formatter
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    astro = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    jsonc = { 'prettierd', 'prettier', stop_after_first = true },
    dart = { 'dart_format' },
    vue = { 'prettierd', 'prettier', stop_after_first = true },
    graphql = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    nix = { 'nixfmt' },
}

--- @type fun(bufnr: integer): conform.FormatOpts
local function format_on_save(bufnr)
    local buffer_filetype = vim.api.nvim_get_option_value('filetype', {
        buf = bufnr,
    })
    if buffer_filetype == 'nix' then
        return {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            -- disable for this reason: https://github.com/neovim/neovim/issues/26520
            lsp_fallback = false,
            formatters = {},
        }
    end

    --- @type conform.FormatOpts
    return {
        async = true,
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        -- disable for this reason: https://github.com/neovim/neovim/issues/26520
        lsp_fallback = false,
    }
end

---@type conform.setupOpts
local config = {
    formatters_by_ft = formatters_by_ft,
    format_on_save = format_on_save,
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.DEBUG,
    -- Conform will notify you when a formatter errors
    notify_on_error = false,
}

local conform = require('conform')
conform.setup(config)
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set({ 'n' }, '<leader><leader>f', function()
    conform.format({
        async = true,
    })
end)
