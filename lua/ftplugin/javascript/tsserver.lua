return function ()
  local nvim_lsp = require('lspconfig')
	nvim_lsp.tsserver.setup { on_attach = require('completion').on_attach }
end
