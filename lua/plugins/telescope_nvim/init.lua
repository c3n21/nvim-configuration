local mappings_enum = require('mappings')
local layout_config = {
    width = 0.8,
    height = 0.4,
    preview_cutoff = 1,
}
local DROPDOWN_THEME = 'dropdown'

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-smart-history.nvim',
        'kkharji/sqlite.lua',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
    },
    config = function()
        local telescope = require('telescope')
        local themes = require('telescope.themes')

        local previewers = require('telescope.previewers')
        local conf = require('telescope.config').values
        telescope.setup({
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                file_browser = {
                    theme = 'ivy',
                    -- disables netrw and use telescope-file-browser in its place
                    -- hijack_netrw = true,
                    -- mappings = {
                    --   ["i"] = {
                    --     -- your custom insert mode mappings
                    --   },
                    --   ["n"] = {
                    --     -- your custom normal mode mappings
                    --   },
                    -- },
                },
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown({
                        -- even more opts
                    }),

                    -- pseudo code / specification for writing custom displays, like the one
                    -- for "codeactions"
                    -- specific_opts = {
                    --   [kind] = {
                    --     make_indexed = function(items) -> indexed_items, width,
                    --     make_displayer = function(widths) -> displayer
                    --     make_display = function(displayer) -> function(e)
                    --     make_ordinal = function(e) -> string
                    --   },
                    --   -- for example to disable the custom builtin "codeactions" display
                    --      do the following
                    --   codeactions = false,
                    -- }
                },
            },
            defaults = {
                cache_picker = {
                    num_pickers = -1,
                    limit_entries = 1000,
                },
                mappings = {
                    n = {
                        ['<C-d>'] = require('telescope.actions').delete_buffer,
                    },
                    i = {
                        ['<C-Down>'] = require('telescope.actions').cycle_history_next,
                        ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
                    },
                },
                history = {
                    path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
                    limit = 100,
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                },
                prompt_prefix = '> ',
                selection_caret = '> ',
                entry_prefix = '  ',
                initial_mode = 'normal',
                selection_strategy = 'closest',
                sorting_strategy = 'descending',
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        mirror = false,
                    },
                    vertical = {
                        mirror = false,
                    },
                },
                file_sorter = require('telescope.sorters').get_fuzzy_file,
                file_ignore_patterns = {},
                generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
                winblend = 0,
                border = {},
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                color_devicons = true,
                path_display = {
                    'smart',
                },
                set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                file_previewer = require('telescope.previewers').vim_buffer_cat.new,
                grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
                qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
            },
            pickers = {
                lsp_references = {
                    layout_strategy = 'vertical',
                    -- theme = DROPDOWN_THEME,
                    -- layout_config = layout_config,
                    -- previewer = require('telescope.previewers').vim_buffer_cat.new,
                },
                find_files = {
                    theme = DROPDOWN_THEME,
                    layout_config = layout_config,
                },
                buffers = {
                    theme = DROPDOWN_THEME,
                    layout_config = layout_config,
                },
            },
        })

        local builtin = require('telescope.builtin')
        local map_opts = { noremap = true, silent = true }
        vim.keymap.set({ 'n' }, '<leader>bo', function()
            builtin.buffers({
                only_cwd = vim.fn.haslocaldir() == 1,
                sort_mru = true,
                ignore_current_buffer = true,
            })
        end, map_opts)

        vim.keymap.set({ 'n' }, mappings_enum['FindFiles'], builtin.find_files, map_opts)
        vim.keymap.set({ 'n' }, mappings_enum['COpen'], builtin.quickfix, map_opts)
        vim.keymap.set({ 'n' }, mappings_enum['LOpen'], builtin.loclist, map_opts)
        vim.keymap.set({ 'n', 'i' }, '<C-p>g', builtin.git_files, map_opts)

        local extensions = {
            'ui-select',
            --[[ 'projects', ]]
            'smart_history',
            'fzf',
            -- 'file_browser'
        }

        for _, value in ipairs(extensions) do
            telescope.load_extension(value)
        end

        require('plugins.telescope_nvim.hydra')
    end,
}
