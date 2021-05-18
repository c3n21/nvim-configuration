local lspconfig = require 'lspconfig'
local root_pattern = lspconfig.util.root_pattern
require'lspconfig'.jdtls.setup{
    root_dir = root_pattern(".git", "pom.xml")
}
