local default_sources = {
    'avante',
    'copilot',
    'lsp',
    'path',
    'snippets',
    'buffer',
}

-- TODO: refactor to nixCats
local lua_source = vim.list_extend({
    'lazydev',
}, default_sources)

require('blink.cmp').setup({
    fuzzy = {
        -- Controls which implementation to use for the fuzzy matcher.
        --
        -- 'prefer_rust_with_warning' (Recommended) If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
        -- 'prefer_rust' If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
        -- 'rust' Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
        -- 'lua' Always use the Lua implementation, doesn't download any prebuilt binaries
        --
        -- See the prebuilt_binaries section for controlling the download behavior
        implementation = 'prefer_rust_with_warning',

        -- Allows for a number of typos relative to the length of the query
        -- Set this to 0 to match the behavior of fzf
        -- Note, this does not apply when using the Lua implementation.
        max_typos = function(keyword)
            return math.floor(#keyword / 4)
        end,

        -- Frecency tracks the most recently/frequently used items and boosts the score of the item
        -- Note, this does not apply when using the Lua implementation.
        frecency = {
            -- Whether to enable the frecency feature
            enabled = true,
            -- Location of the frecency database
            path = vim.fn.stdpath('state') .. '/blink/cmp/frecency.dat',
            -- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database.
            -- This should only be used on unsupported platforms (i.e. alpine termux)
            unsafe_no_lock = false,
        },

        -- Proximity bonus boosts the score of items matching nearby words
        -- Note, this does not apply when using the Lua implementation.
        use_proximity = true,

        -- Controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
        -- You may pass a function instead of a string to customize the sorting
        sorts = {
            -- (optionally) always prioritize exact matches
            -- 'exact',

            -- pass a function for custom behavior
            -- function(item_a, item_b)
            --   return item_a.score > item_b.score
            -- end,

            'score',
            'sort_text',
        },

        prebuilt_binaries = {
            -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
            -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
            -- Disabled by default when `fuzzy.implementation = 'lua'`
            download = false,

            -- Ignores mismatched version between the built binary and the current git sha, when building locally
            ignore_version_mismatch = false,

            -- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
            -- then the downloader will attempt to infer the version from the checked out git tag (if any).
            --
            -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
            force_version = nil,

            -- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
            -- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
            -- Check the latest release for all available system triples
            --
            -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
            force_system_triple = nil,

            -- Extra arguments that will be passed to curl like { 'curl', ..extra_curl_args, ..built_in_args }
            extra_curl_args = {},

            proxy = {
                -- When downloading a prebuilt binary, use the HTTPS_PROXY environment variable
                from_env = true,

                -- When downloading a prebuilt binary, use this proxy URL. This will ignore the HTTPS_PROXY environment variable
                url = nil,
            },
        },
    },
    enabled = function()
        return vim.bo.buftype ~= 'nofile' -- when renaming using fzf-lua I don't want completion
            and vim.bo.buftype ~= 'prompt'
            and vim.b.completion ~= false
            and vim.api.nvim_get_mode().mode ~= 'c'
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
    },
    cmdline = {
        keymap = {
            preset = 'none',
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
        kind_icons = {
            Copilot = '',
        },

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
        default = function(ctx)
            if vim.bo.filetype == 'lua' then
                return lua_source
            end
            return default_sources
        end,
        providers = {
            avante = {
                module = 'blink-cmp-avante',
                name = 'Avante',
                opts = {
                    -- options for blink-cmp-avante
                },
            },
            copilot = {
                name = 'copilot',
                module = 'blink-copilot',
                score_offset = 100,
                async = true,
            },
            lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },
})
