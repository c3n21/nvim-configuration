require('blink.cmp').setup({
    enabled = function()
        return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false and vim.api.nvim_get_mode().mode ~= 'c'
    end,
    signature = {
        enabled = true,
    },
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<Cr>'] = { 'select_and_accept', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

        cmdline = {
            preset = 'none',
            -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            -- ['<C-e>'] = { 'cancel', 'fallback' },
            --
            -- ['<Up>'] = { 'select_prev', 'fallback' },
            -- ['<Down>'] = { 'select_next', 'fallback' },
            -- ['<S-Tab>'] = { 'select_prev', 'fallback' },
            -- ['<Tab>'] = { 'select_next', 'fallback' },
        },
    },
    completion = {
        list = {
            selection = {
                preselect = false,
                auto_insert = false,
            },
        },
        ghost_text = {
            enabled = true,
        },
    },
    appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})
