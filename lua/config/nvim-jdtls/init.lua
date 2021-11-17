if packer_plugins["nvim-jdtls"] then
    local coq = require "coq" -- add this
    local jdtls = require "jdtls"

    local workspace_root = os.getenv('HOME') .. '/.config/nvim-jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')

    local config = coq.lsp_ensure_capabilities({
        cmd = {
            'jdtls.sh', workspace_root,
        },
        root_dir = jdtls.setup.find_root({'gradle.build', 'pom.xml', ".git"})
    })

    jdtls.start_or_attach(config)
else
    print("nvim-jdtls not installed")
end
