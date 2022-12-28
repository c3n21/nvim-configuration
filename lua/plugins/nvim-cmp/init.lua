return {
    'hrsh7th/nvim-cmp',
    --event = 'InsertEnter',
    dependencies = {
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
    },
    config = function()
        local cmp = require('cmp')
        require('copilot_cmp').setup({
            method = 'getCompletionsCycling',
            formatters = {
                label = require('copilot_cmp.format').format_label_text,
                insert_text = require('copilot_cmp.format').format_insert_text,
                preview = require('copilot_cmp.format').deindent,
            },
        })

        --[[ local has_words_before = function() ]]
        --[[     local line, col = unpack(vim.api.nvim_win_get_cursor(0)) ]]
        --[[     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil ]]
        --[[ end ]]

        local has_words_before = function()
            if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
                return false
            end
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
        end

        -- local feedkey = function(key, mode)
        --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        -- end

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
            experimental = {
                ghost_text = true,
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
                --[[ { name = 'nvim_lsp_signature_help' }, ]]
                { name = 'neorg', group_index = 2 },
                { name = 'nvim_lsp', group_index = 2 },
                { name = 'copilot', group_index = 2 },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip', group_index = 2 }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
                { name = 'buffer', group_index = 2 },
                { name = 'path' },
                { name = 'cmdline' },
            }),
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
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
    end,
}
