local coq = require "coq" -- add this
local jdtls = require "jdtls"

local workspace_root = os.getenv('HOME') .. '/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')

local config = coq.lsp_ensure_capabilities({
    cmd = {
        '/usr/bin/jdtls',
        '-data', workspace_root
    },
    root_dir = jdtls.setup.find_root({'gradle.build', 'pom.xml', ".git"})
})

jdtls.start_or_attach(config)
