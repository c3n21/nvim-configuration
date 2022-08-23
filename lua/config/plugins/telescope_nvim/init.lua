local telescope = require('telescope')

telescope.setup({
    extensions = {
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
        path_display = {},
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    },
})

local extensions = {
    'ui-select',
    'projects',
    'smart_history',
    -- 'file_browser'
}

for _, value in ipairs(extensions) do
    telescope.load_extension(value)
end
