local mappings_enum = require('mappings')

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-smart-history.nvim',
        'kkharji/sqlite.lua',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    config = function()
        local telescope = require('telescope')
        local themes = require('telescope.themes')

        local previewers = require('telescope.previewers')
        local actions = require('telescope.actions')
        local sorters = require('telescope.sorters')

        telescope.setup({
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ['ui-select'] = {
                    themes.get_dropdown({
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
                        ['<C-d>'] = actions.delete_buffer,
                    },
                    i = {
                        ['<C-Down>'] = actions.cycle_history_next,
                        ['<C-Up>'] = actions.cycle_history_prev,
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
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {
                        preview_cutoff = -1,
                        height = 0.9,
                        prompt_position = 'bottom',
                        width = 0.8,
                    },
                },
                file_sorter = sorters.get_fuzzy_file,
                file_ignore_patterns = {},
                generic_sorter = sorters.get_generic_fuzzy_sorter,
                winblend = 0,
                border = {},
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                color_devicons = true,
                path_display = {
                    'smart',
                },
                set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                file_previewer = previewers.vim_buffer_cat.new,
                grep_previewer = previewers.vim_buffer_vimgrep.new,
                qflist_previewer = previewers.vim_buffer_qflist.new,

                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = previewers.buffer_previewer_maker,
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
        vim.keymap.set({ 'n', 'i' }, '<M-t>gf', builtin.git_files, map_opts)
        vim.keymap.set({ 'n', 'i' }, '<M-t>r', builtin.resume, map_opts)
        vim.keymap.set({ 'n', 'i' }, '<M-t>d', builtin.diagnostics, map_opts)
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                -- print(vim.inspect(args))
                -- local bufnr = args.buf
                -- local client = vim.lsp.get_client_by_id(args.data.client_id)
                -- if client.server_capabilities.completionProvider then
                --     vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                -- end
                -- if client.server_capabilities.definitionProvider then
                --     vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
                -- end
            end,
        })

        local extensions = {
            'ui-select',
            'smart_history',
            'fzf',
        }

        for _, value in ipairs(extensions) do
            telescope.load_extension(value)
        end
    end,
}
