_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
    },
}
local success, _ = pcall(require, 'impatient')
local fmt = string.format

vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'

local settings_config = {
    enable_dap = {
        'php',
    },
    enable_lsp = {
        'pyright',
        'tsserver',
        'clangd',
        'dartls',
        'ocamllsp',
        'intelephense',
        'tailwindcss',
        'erlangls'
        -- 'rust_analyzer',
        -- "sumneko_lua" using lua-dev
        -- "fsautocomplete",
        -- "rnix",
        -- "efm"
    },
    log_level = vim.log.levels.WARN,
    completion = 'nvim-cmp',
}

local settings

success, settings = pcall(require, 'settings')
if not success then
    vim.notify(fmt('Error loading settings: %s', vim.inspect(success)), vim.log.levels.WARN)
else
    settings.setup(settings_config)
end

require('mappings')
success, settings = pcall(require, 'packer_compiled')
if not success then
    vim.notify(fmt('Error loading packer_compiled: %s', vim.inspect(success)), vim.log.levels.WARN)
end
