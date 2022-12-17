require('neoconf').setup(
    -- override any of the default settings here
    --[[ { ]]
    --[[     -- name of the local settings files ]]
    --[[     local_settings = '.neoconf.json', ]]
    --[[     -- name of the global settings file in your Neovim config directory ]]
    --[[     global_settings = 'neoconf.json', ]]
    --[[     -- import existing settinsg from other plugins ]]
    --[[     import = { ]]
    --[[         vscode = true, -- local .vscode/settings.json ]]
    --[[         coc = true, -- global/local coc-settings.json ]]
    --[[         nlsp = true, -- global/local nlsp-settings.nvim json settings ]]
    --[[     }, ]]
    --[[     -- send new configuration to lsp clients when changing json settings ]]
    --[[     live_reload = true, ]]
    --[[     -- set the filetype to jsonc for settings files, so you can use comments ]]
    --[[     -- make sure you have the jsonc treesitter parser installed! ]]
    --[[     filetype_jsonc = true, ]]
    --[[     plugins = { ]]
    --[[         -- configures lsp clients with settings in the following order: ]]
    --[[         -- - lua settings passed in lspconfig setup ]]
    --[[         -- - global json settings ]]
    --[[         -- - local json settings ]]
    --[[         lspconfig = { ]]
    --[[             enabled = true, ]]
    --[[         }, ]]
    --[[         -- configures jsonls to get completion in .nvim.settings.json files ]]
    --[[         jsonls = { ]]
    --[[             enabled = true, ]]
    --[[             -- only show completion in json settings for configured lsp servers ]]
    --[[             configured_servers_only = true, ]]
    --[[         }, ]]
    --[[         -- configures sumneko_lua to get completion of lspconfig server settings ]]
    --[[         sumneko_lua = { ]]
    --[[             -- by default, sumneko_lua annotations are only enabled in your neovim config directory ]]
    --[[             enabled_for_neovim_config = true, ]]
    --[[             -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file ]]
    --[[             enabled = false, ]]
    --[[         }, ]]
    --[[     }, ]]
    --[[ } ]]
)

local navic = require('nvim-navic')

navic.setup({
    icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = '練',
        Interface = '練',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = '◩ ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = 'ﳠ ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
    },
    highlight = true,
    separator = ' || ',
    depth_limit = 0,
    depth_limit_indicator = '..',
    safe_output = true,
})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == 'null-ls'
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end

    local opts = { noremap = true, silent = true }
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    --[[ vim.keymap.set({ 'n' }, '<leader>bo', function() ]]
    --[[     require('telescope.builtin').buffers({ only_cwd = vim.fn.haslocaldir() == 1 }) ]]
    --[[ end, opts) ]]
    local builtin = require('telescope.builtin')

    vim.keymap.set({ 'n' }, 'gr', builtin.lsp_references, opts)
    vim.keymap.set({ 'n' }, '<leader>ldd', builtin.diagnostics, opts)
    --TODO: use these again
    --[[ vim.keymap.set({ 'n' }, '<leader>ld', builtin.lsp_document_symbols, opts) ]]
    --[[ vim.keymap.set({ 'n' }, '<leader>lw', builtin.lsp_workspace_symbols, opts) ]]

    -- LSP
    vim.keymap.set({ 'n', 'i' }, '<C>]', builtin.lsp_definitions, opts)
    vim.keymap.set({ 'n' }, 'gD', builtin.lsp_type_definitions, opts)
    vim.keymap.set({ 'n' }, 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set({ 'n' }, 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.declaration, opts)
    vim.keymap.set({ 'n' }, 'H', vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n' }, '<leader><leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set({ 'n' }, '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set({ 'n' }, ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set({ 'n' }, '<leader>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set({ 'n' }, '<leader><leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set({ 'n' }, '<leader>lw', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set({ 'n' }, '<leader>ld', vim.lsp.buf.document_symbol, opts)
end

-- rust
require('rust-tools').setup({ server = { on_attach = on_attach } })

-- metals
local metals_config = require('metals').bare_config()
local completion = require('settings').completion

metals_config = completion(metals_config)
metals_config.on_attach = on_attach

metals_config.settings = {
    showImplicitArguments = true,
    excludePackages = {
        'akka.actor.typed.javadsl',
        'com.github.swagger.akka.javadsl',
    },
}

require('neodev').setup({
    library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
    -- add any options here, or leave empty to use the default settings
})

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')

-- example to setup sumneko and enable call snippets
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            --[[ diagnostics = {
                -- Get the language server to recognize the `vim` global
            }, ]]
            workspace = {
                maxPreload = 5000,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = 'Replace',
            },
        },
    },
})

local config = require('settings').get_config()

local language_servers = config.enable_lsp
--[[ local language_servers = {
    'pyright',
    'tsserver',
    'clangd',
    'dartls',
    'ocamllsp',
    'intelephense',
    'tailwindcss',
    'erlangls',
    'eslint',
    -- 'rust_analyzer',
    -- "sumneko_lua" using lua-dev
    -- "fsautocomplete",
    -- "rnix",
    -- "efm"
} ]]

for _, language_server in pairs(language_servers) do
    local ls_config = require(string.format('config.plugins.nvim-lspconfig.%s', language_server))
    ls_config = completion(ls_config)
    ls_config.on_attach = on_attach
    lspconfig[language_server].setup(ls_config)
end

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

return on_attach
