-- local jdtls = require "jdtls"
-- local system_config = require("config")
-- local current = system_config.completion.current
-- local workspace_root = os.getenv('HOME') .. '/.config/nvim-jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')
-- local config = {
--     cmd = {
--         'jdtls.sh', workspace_root,
--     },
--     root_dir = jdtls.setup.find_root({'gradle.build', 'pom.xml', ".git"})
-- }

-- config = system_config.completion[current](config)

-- return config

vim.cmd [[
augroup jdtls_lsp
autocmd!
autocmd FileType java lua require'jdtls'.start_or_attach(require('config.plugins.nvim-jdtls.config'))
augroup end]]
