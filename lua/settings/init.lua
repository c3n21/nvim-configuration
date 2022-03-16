vim.o.path = vim.o.path .. "**"

vim.g.mapleader = " "
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    }
)

local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

-- vim.api.nvim_set_keymap('n', '<leader>cq', ':cclose <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>co', ':copen <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>cn', ':cnext <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>cN', ':cprevious <CR>', opts)

-- vim.api.nvim_set_keymap('n', '<leader>Cn', ':cnext <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>CN', ':cprevious <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>Co', ':lopen <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>Cq', ':lclose <CR>', opts)

-- local maps = require("map")
-- local mode, mapping =  unpack(maps.buffer)
-- vim.api.nvim_set_keymap(mode, mapping, ":BufferLinePick<CR>", opts)

-- mode, mapping =  unpack(maps.buffer.n.close)
-- vim.api.nvim_set_keymap(mode, mapping, ":BufferLinePickClose<CR>", opts)
--
local maps = require('config').mappings
for lhs, map in pairs(maps) do
    for rhs, map_opts in pairs(map) do
        vim.keymap.set(map_opts.modes, lhs, rhs, map_opts.opts)
    end
end
