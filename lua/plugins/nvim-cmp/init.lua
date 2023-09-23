return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'zbirenbaum/copilot-cmp',
        'zbirenbaum/copilot.lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
        'hrsh7th/cmp-path',
        'rcarriga/cmp-dap',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'windwp/nvim-autopairs',
    },
    config = function()
        local cmp = require('cmp')
        local copilot_cmp = require('copilot_cmp')
        copilot_cmp.setup()

        --[[ cmp.event:on('menu_opened', function() ]]
        --[[     vim.b.copilot_suggestion_hidden = true ]]
        --[[ end) ]]

        --[[ cmp.event:on('menu_closed', function() ]]
        --[[     vim.b.copilot_suggestion_hidden = false ]]
        --[[ end) ]]

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return not vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
                and (col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil)
        end

        -- local cmp_kinds = {
        --     Text = '  ',
        --     Method = '  ',
        --     Function = '  ',
        --     Constructor = '  ',
        --     Field = '  ',
        --     Variable = '  ',
        --     Class = '  ',
        --     Interface = '  ',
        --     Module = '  ',
        --     Property = '  ',
        --     Unit = '  ',
        --     Value = '  ',
        --     Enum = '  ',
        --     Keyword = '  ',
        --     Snippet = '  ',
        --     Color = '  ',
        --     File = '  ',
        --     Reference = '  ',
        --     Folder = '  ',
        --     EnumMember = '  ',
        --     Constant = '  ',
        --     Struct = '  ',
        --     Event = '  ',
        --     Operator = '  ',
        --     TypeParameter = '  ',
        -- }
        local cmp_buffer = require('cmp_buffer')

        cmp.setup({
            enabled = function()
                return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
            end,

            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
                end,
            },

            -- formatting = {
            --     format = function(_, vim_item)
            --         vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            --         return vim_item
            --     end,
            -- },
            --[[ window = { ]]
            --[[     completion = cmp.config.window.bordered({ ]]
            --[[         -- side_padding = 30, ]]
            --[[         -- col_offset = 100, ]]
            --[[         -- max_width = 30, ]]
            --[[         -- zindex = 100 ]]
            --[[     }), ]]
            --[[     documentation = cmp.config.window.bordered({ ]]
            --[[         -- max_width = 30, ]]
            --[[         -- max_height = 30, ]]
            --[[         -- zindex = 100 ]]
            --[[     }), ]]
            --[[ }, ]]
            --
            experimental = {
                -- Temporary workaround for https://github.com/hrsh7th/nvim-cmp/issues/1565
                ghost_text = {
                    enabled = true,
                },
            },

            mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }, { 'i' }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        -- elseif luasnip.expand_or_jumpable() then
                        --     luasnip.expand_or_jump()
                        -- elseif vim.fn["vsnip#available"](1) == 1 then
                        --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                    end
                end, { 'i' }),

                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        -- elseif luasnip.jumpable(-1) then
                        --     luasnip.jump(-1)
                        -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                        --   feedkey("<Plug>(vsnip-jump-prev)", "")
                    end
                end, { 'i' }),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help', group_index = 1 },
                { name = 'nvim_lsp', group_index = 1, dup = 0 },
                { name = 'copilot', group_index = 1, dup = 0 },
                { name = 'luasnip', group_index = 1, dup = 0 }, -- For luasnip users.
                { name = 'neorg', group_index = 1, dup = 0 },
                {
                    name = 'buffer',
                    group_index = 2,
                    dup = 0,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                { name = 'path', dup = 0 },
                --[[ { name = 'cmdline' }, ]]
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    function(...)
                        return cmp_buffer:compare_locality(...)
                    end,
                    -- The rest of your comparators...
                    require('copilot_cmp.comparators').prioritize,
                    require('copilot_cmp.comparators').score,
                    cmp.config.compare.kind,
                    cmp.config.compare.scopes,
                    cmp.config.compare.exact,
                    -- Below is the default comparitor list and order for nvim-cmp
                    cmp.config.compare.offset,
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
                --[[ { name = 'nvim_lsp_document_symbol' }, ]]
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
        })

        --cmp.setup.cmdline(':', {
        --    sources = cmp.config.sources({
        --        { name = 'path' },
        --        { name = 'cmdline' },
        --    }),
        --})

        require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
            sources = {
                { name = 'dap' },
            },
        })

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
}
