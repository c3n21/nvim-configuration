local fmt = string.format
-- settings sets default configuration, thus should be required before everything
local success, _ = pcall(require, 'settings')
if not success then
    vim.notify(fmt('Error loading settings: %s', vim.inspect(success)), vim.log.levels.WARN)
end

local mappings = require('mappings')

vim.lsp.config('*', {
    on_attach = function(client, bufnr)
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
            vim.keymap.set('n', mappings['Hover'], vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
        end
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = bufnr })
                end,
            })
        end
    end,
})

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

-- Create an autocommand group to manage the autocommands
local inlay_hints_augroup = vim.api.nvim_create_augroup('ToggleInlayHints', { clear = true })

-- Disable inlay hints when entering Insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
    group = inlay_hints_augroup,
    callback = function()
        vim.lsp.inlay_hint.enable(false)
    end,
})

-- UI2
require('vim._core.ui2').enable({
    enable = true, -- Whether to enable or disable the UI.
    msg = { -- Options related to the message module.
        ---@type 'cmd'|'msg' Default message target, either in the
        ---cmdline or in a separate ephemeral message window.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds and triggers to a target.
        targets = 'cmd',
        cmd = { -- Options related to messages in the cmdline window.
            height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        dialog = { -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
            height = 0.5, -- Maximum height.
            timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
            height = 1, -- Maximum height.
        },
    },
})

-- Treesitter
vim.g.query_lint_on = { 'InsertLeave', 'TextChanged' }

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        if ft == '' then
            return
        end
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        -- The assumption is that vim.treesitter.start already disables the default
        -- syntax engine. In case this is going to be changed decomment the following line:
        -- vim.o.syntax = 'off'
        pcall(vim.treesitter.start, buf)
    end,
})

vim.api.nvim_create_user_command('Terminal', function(opts)
    vim.cmd({
        cmd = 'terminal',
        args = opts.fargs,
    })

    vim.wo.number = true
    vim.wo.relativenumber = true
end, {
    nargs = '*',
    complete = 'shellcmd',
})
