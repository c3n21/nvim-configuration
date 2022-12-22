return {
    'nvim-neorg/neorg',
    config = function()
        local neorg = require('neorg')

        neorg.setup({
            load = {
                ['core.defaults'] = {}, -- Load all the defaults
                ['core.norg.completion'] = {
                    config = {
                        -- Note that this table is optional and doesn't need to be provided
                        -- Configuration here
                        engine = 'nvim-cmp',
                    },
                },
                ['core.norg.concealer'] = {
                    config = {
                        icon_preset = 'diamond',
                        -- markup_preset = "dimmed",
                    },
                }, -- Allows the use of icons
                -- ["core.keybinds"] = {
                --     config = {
                --         default_keybinds = true,
                --         -- neorg_leader = "<Leader>o",
                --         hook = function(keybinds)
                --             keybinds.remap_key("traverse-heading", "n", "k", "<M-k>")
                --         end,
                --     },
                -- },
                ['core.norg.dirman'] = { -- Manage Neorg directories
                    config = {
                        workspaces = {
                            work = '~/Documents/Notes',
                        },

                        autochdir = false,
                        default_workspace = 'work',
                    },
                },
                -- ["core.integrations.treesitter"] = {
                --     config = {
                --         parser_configs = {
                --             norg = {
                --                 url = "~/dev/tree-sitter-norg"
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
                ['core.norg.journal'] = {},
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

        neorg.modules.load_module('core.norg.completion', nil, {
            engine = 'nvim-cmp',
        })
    end,
}
