print("Adding completion-nvim")
local lsp = require('lspconfig')
lsp.pyright.setup{on_attach=require'completion'.on_attach}
