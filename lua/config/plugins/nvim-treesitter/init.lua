local ts_setup = require('nvim-treesitter.configs')

ts_setup.setup({
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { 'BufWrite', 'CursorHold', 'InsertLeave' },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    -- for Comment.nvim (https://github.com/JoosepAlviste/nvim-ts-context-commentstring#integrations)
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    ensure_installed = { 'c', 'bash', 'html', 'javascript', 'lua', 'python', 'php', 'http', 'json' }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages

    highlight = {
        enable = true, -- false will disable the whole extension
        --disable = { "c", "rust" },  -- list of language that will be disabled
        use_languagetree = true, -- Use this to enable language injection (this is very unstable)
        --custom_captures = {
        --    -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        --    ["*.bar"] = "lua",
        --},
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },

    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = 'gnd',
                list_definitions = 'gnD',
                list_definitions_toc = 'gO',
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-#>',
            },
        },
    },

    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',

                -- Or you can define your own textobjects like this
                ['iF'] = {
                    python = '(function_definition) @function',
                    cpp = '(function_definition) @function',
                    c = '(function_definition) @function',
                    java = '(method_declaration) @function',
                },
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ['df'] = '@function.outer',
                ['dF'] = '@class.outer',
            },
        },
    },
})
