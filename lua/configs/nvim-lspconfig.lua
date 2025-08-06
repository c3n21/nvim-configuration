local mappings_enum = require('mappings')
local map_opts = { noremap = true, silent = true }

-- vim.keymap.set({ 'n' }, mappings_enum['Hover'], vim.lsp.buf.hover, map_opts)

-- vim.keymap.set({ 'n' }, mappings_enum['SignatureHelp'], vim.lsp.buf.signature_help, map_opts)

vim.keymap.set({ 'n' }, mappings_enum['ToggleInlayHints'], function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, map_opts)

-- --        require('neoconf').setup()
-- -- needing this only because nvim-java requires mason
-- -- require('mason').setup({
-- --     registries = {
-- --         'github:nvim-java/mason-registry',
-- --         'github:mason-org/mason-registry',
-- --     },
-- -- })
-- -- require('mason-lspconfig').setup()
-- -- require('java').setup({
-- --     jdk = {
-- --         -- install jdk using mason.nvim
-- --         auto_install = false,
-- --         version = '17.0.2',
-- --     },
-- --
-- --     spring_boot_tools = {
-- --         enable = false,
-- --     },
-- -- })
-- -- require('plugins.nvim-cmp')
-- require('plugins.blink')
-- vim.g.markdown_fenced_languages = {
--     'ts=typescript',
-- }

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities = require('blink.cmp').get_lsp_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
-- }

-- -- local on_attach = require('plugins.lsp.on_attach')

-- -- local flutter_tools = require('flutter-tools')
-- -- flutter_tools.setup({
-- --     lsp = {
-- --         on_attach = on_attach,
-- --     },
-- -- })

-- -- local options = {
-- --     on_attach = on_attach,
-- --     capabilities = capabilities,
-- --     flags = {
-- --         debounce_text_changes = 150,
-- --     },
-- -- }

-- --        local rt = require('rust-tools')
-- --        rt.setup({
-- --            server = {
-- --                on_attach = function(client, bufnr)
-- --                    on_attach.lsp_attach(client, bufnr)
-- --                    -- Hover actions
-- --                    vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
-- --                    -- Code action groups
-- --                    vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
-- --                end,
-- --            },
-- --        })

-- -- metals
-- --[[ local metals_config = require('metals').bare_config() ]]
-- --local completion = require("settings").completion

-- --metals_config = completion(metals_config)
-- --[[ metals_config.on_attach = on_attach ]]

-- --[[ metals_config.settings = { ]]
-- --[[     showImplicitArguments = true, ]]
-- --[[     excludePackages = { ]]
-- --[[         'akka.actor.typed.javadsl', ]]
-- --[[         'com.github.swagger.akka.javadsl', ]]
-- --[[     }, ]]
-- --[[ } ]]

-- -- then setup your lsp server as usual
-- -- local lspconfig = require('lspconfig')
-- local gonvim = require('go')
-- gonvim.setup({
--     lsp_cfg = false,
-- })

-- -- local servers = require('plugins.lsp.servers')
-- -- for ls_name, ls_config in pairs(servers) do
-- --     local opts = vim.tbl_deep_extend('force', {}, options, ls_config or {})
-- --     lspconfig[ls_name].setup(opts)
-- -- end

-- -- Enable inlay hints when leaving Insert mode (returning to Normal mode)
-- -- vim.api.nvim_create_autocmd('InsertLeave', {
-- --     group = augroup,
-- --     callback = function()
-- --         vim.lsp.inlay_hint.enable(true)
-- --     end,
-- -- })
