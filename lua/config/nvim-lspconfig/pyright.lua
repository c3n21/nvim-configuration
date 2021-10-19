local pyright = require'lspconfig'.pyright
local coq = require('coq')


pyright.setup(coq.lsp_ensure_capabilities({}))

return pyright
