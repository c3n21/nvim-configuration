local lspconfig = require('lspconfig')
local tsserver = lspconfig.tsserver
tsserver.setup{}

return tsserver
