local lspconfig = require('lspconfig')
local root_pattern = lspconfig.util.root_pattern
lspconfig.jdtls.setup{
    root_dir = root_pattern(".git", "pom.xml"),
}
