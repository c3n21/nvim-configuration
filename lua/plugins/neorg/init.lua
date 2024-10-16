return {
    'nvim-neorg/neorg',
    dependencies = {
        'hrsh7th/nvim-cmp',
        {
            'vhyrro/luarocks.nvim',
            priority = 1000,
            config = true,
        },
    },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = function()
        local neorg = require('neorg')

        neorg.setup({
            load = {
                ['core.esupports.indent'] = {},
                ['core.defaults'] = {}, -- Load all the defaults
                ['core.completion'] = {
                    config = {
                        -- Note that this table is optional and doesn't need to be provided
                        -- Configuration here
                        engine = 'nvim-cmp',
                    },
                },
                ['core.concealer'] = {
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
                ['core.dirman'] = { -- Manage Neorg directories
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

        neorg.modules.load_module('core.completion', nil, {
            engine = 'nvim-cmp',
        })
    end,
}
