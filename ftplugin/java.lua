-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--[[ local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') ]]
--[[ local root_markers = { '.git', 'mvnw', 'gradlew' } ]]
--[[ local root_dir = require('jdtls.setup').find_root(root_markers) ]]
--[[ local home = os.getenv('HOME') ]]
--[[ local _configuration = home .. '/.local/share/java/jdtls/config_linux' ]]

--[[ local _data = home .. '/.local/jdtls/' .. project_name ]]

local config = require('plugins.nvim-jdtls.config')
require('jdtls').start_or_attach(config)
