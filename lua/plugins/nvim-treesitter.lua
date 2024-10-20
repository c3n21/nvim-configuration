local ts_setup = require('nvim-treesitter.configs')
-- require('ts_context_commentstring').setup({})
-- vim.g.skip_ts_context_commentstring_module = true
ts_setup.setup({
    -- query_linter = {
    --     enable = true,
    --     use_virtual_text = true,
    --     lint_events = { 'BufWrite', 'CursorHold', 'InsertLeave' },
    -- },
    -- playground = {
    --     enable = true,
    --     disable = {},
    --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    --     persist_queries = false, -- Whether the query persists across vim sessions
    --     keybindings = {
    --         toggle_query_editor = 'o',
    --         toggle_hl_groups = 'i',
    --         toggle_injected_languages = 't',
    --         toggle_anonymous_nodes = 'a',
    --         toggle_language_display = 'I',
    --         focus_language = 'f',
    --         unfocus_language = 'F',
    --         update = 'R',
    --         goto_node = '<cr>',
    --         show_help = '?',
    --     },
    -- },
    -- for Comment.nvim (https://github.com/JoosepAlviste/nvim-ts-context-commentstring#integrations)
    -- context_commentstring = {
    --     enable = true,
    --     enable_autocmd = false,
    --     config = {
    --         javascript = {
    --             __default = '// %s',
    --             jsx_element = '{/* %s */}',
    --             jsx_fragment = '{/* %s */}',
    --             jsx_attribute = '// %s',
    --             comment = '// %s',
    --         },
    --         typescript = { __default = '// %s', __multiline = '/* %s */' },
    --     },
    -- },

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

    -- refactor = {
    --     highlight_definitions = { enable = true },
    --     highlight_current_scope = { enable = true },
    --     navigation = {
    --         enable = true,
    --         keymaps = {
    --             goto_definition = 'gnd',
    --             list_definitions = 'gnD',
    --             list_definitions_toc = 'gO',
    --             goto_next_usage = '<a-*>',
    --             goto_previous_usage = '<a-#>',
    --         },
    --     },
    -- },
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
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = { query = '@class.outer', desc = 'Next class start' },
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
            border = 'none',
            peek_definition_code = {
                ['<leader>df'] = '@function.outer',
                ['<leader>dF'] = '@class.outer',
            },
        },
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
        },
    },
})
require('nvim-ts-autotag').setup()
