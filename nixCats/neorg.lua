local neorg = require('neorg')

neorg.setup({
    load = {
        ['core.esupports.indent'] = {},
        ['core.defaults'] = {}, -- Load all the defaults
        ['core.completion'] = {
            config = { engine = { module_name = 'external.lsp-completion' } },
        },
        ['core.concealer'] = {
            -- config = {
            --     icon_preset = 'diamond',
            --     -- markup_preset = "dimmed",
            -- },
        }, -- Allows the use of icons
        ['external.interim-ls'] = {
            config = {
                -- default config shown
                completion_provider = {
                    -- Enable or disable the completion provider
                    enable = true,

                    -- Show file contents as documentation when you complete a file name
                    documentation = true,

                    -- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
                    categories = false,

                    -- suggest heading completions from the given file for `{@x|}` where `|` is your cursor
                    -- and `x` is an alphanumeric character. `{@name}` expands to `[name]{:$/people:# name}`
                    people = {
                        enable = false,

                        -- path to the file you're like to use with the `{@x` syntax, relative to the
                        -- workspace root, without the `.norg` at the end.
                        -- ie. `folder/people` results in searching `$/folder/people.norg` for headings.
                        -- Note that this will change with your workspace, so it fails silently if the file
                        -- doesn't exist
                        path = 'people',
                    },
                },
            },
        },
        -- ["core.keybinds"] = {
        --     config = {
        --         default_keybinds = true,
        --         -- neorg_leader = "<Leader>o",
        --         hook = function(keybinds)
        --             keybinds.remap_key("traverse-heading", "n", "k", "<M-k>")
        --         end,
        --     },
        -- },
        ['core.dirman'] = { -- Manage Neorg directories
            config = {
                workspaces = {
                    work = '~/Documents/Notes',
                    logica = '~/Documents/neorg/logica',
                    scratchpad = '~/Documents/neorg/scratchpad',
                    architettura = '~/Downloads/github/computer-architecture/src/theory',
                },

                autochdir = false,
                default_workspace = 'work',
            },
        },
        -- ["core.integrations.treesitter"] = {
        --     config = {
        --         parser_configs = {
        --            .= {
        --                 url = "~/dev/tree-sitter.
        --             }
        --         }
        --     }
        -- },
        -- ["core.gtd.base"] = {
        --     config = {
        --         workspace = "gtd",
        --     }
        -- },
        -- ["core.presenter"] = {
        --     config = {
        --         zen_mode = "truezen",
        --     },
        -- },
        ['core.journal'] = {},
        ['core.export'] = {},
        -- ["core.upgrade"] = {},
        ['core.export.markdown'] = {
            config = {
                extensions = 'all',
            },
        },
    },

    -- Set custom logger settings
    logger = {
        level = 'warn',
    },
})
