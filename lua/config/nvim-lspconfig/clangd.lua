local coq = require('coq')
return require'lspconfig'.clangd.setup(coq.lsp_ensure_capabilities({}))
