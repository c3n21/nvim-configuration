--        require('neoconf').setup()
require('plugins.nvim-cmp')
local mason_config = require('configs.mason')
require('mason').setup(mason_config)
require('mason-lspconfig').setup()
require('otter').setup({
    lsp = {
        -- `:h events` that cause the diagnostics to update. Set to:
        -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
        -- but more instant diagnostic updates
        diagnostic_update_events = { 'BufWritePost' },
        -- function to find the root dir where the otter-ls is started
        root_dir = function(_, bufnr)
            return vim.fs.root(bufnr or 0, {
                '.git',
                '_quarto.yml',
                'package.json',
            }) or vim.fn.getcwd(0)
        end,
    },
    buffers = {
        -- if set to true, the filetype of the otterbuffers will be set.
        -- otherwise only the autocommand of lspconfig that attaches
        -- the language server will be executed without setting the filetype
        set_filetype = false,
        -- write <path>.otter.<embedded language extension> files
        -- to disk on save of main buffer.
        -- usefule for some linters that require actual files
        -- otter files are deleted on quit or main buffer close
        write_to_disk = false,
    },
    strip_wrapping_quote_characters = { "'", '"', '`' },
    -- otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
    -- When true, otter handles these cases fully.
    handle_leading_whitespace = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local on_attach = require('plugins.lsp.on_attach')

local flutter_tools = require('flutter-tools')
flutter_tools.setup({
    lsp = {
        on_attach = on_attach,
    },
})

local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

--        local rt = require('rust-tools')
--        rt.setup({
--            server = {
--                on_attach = function(client, bufnr)
--                    on_attach.lsp_attach(client, bufnr)
--                    -- Hover actions
--                    vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
--                    -- Code action groups
--                    vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
--                end,
--            },
--        })

-- metals
--[[ local metals_config = require('metals').bare_config() ]]
--local completion = require("settings").completion

--metals_config = completion(metals_config)
--[[ metals_config.on_attach = on_attach ]]

--[[ metals_config.settings = { ]]
--[[     showImplicitArguments = true, ]]
--[[     excludePackages = { ]]
--[[         'akka.actor.typed.javadsl', ]]
--[[         'com.github.swagger.akka.javadsl', ]]
--[[     }, ]]
--[[ } ]]

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')

local servers = require('plugins.lsp.servers')
for ls_name, ls_config in pairs(servers) do
    local opts = vim.tbl_deep_extend('force', {}, options, ls_config or {})
    lspconfig[ls_name].setup(opts)
end
