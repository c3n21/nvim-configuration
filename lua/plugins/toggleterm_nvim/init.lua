return {
    'akinsho/toggleterm.nvim',
    enabled = false,
    config = function()
        vim.o.hidden = true
        require('toggleterm').setup({
            -- size can be a number or function which is passed the current terminal
            size = 20, --| function(term)
            --   if term.direction == "horizontal" then
            --     return 15
            --   elseif term.direction == "vertical" then
            --     return vim.o.columns * 0.4
            --   end
            -- end,
            open_mapping = [[<c-t>]],
            hide_numbers = false, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            auto_scroll = true,
            shade_terminals = true,
            shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            persist_size = true,
            direction = 'horizontal', -- | 'horizontal' | 'tab' | 'float',
            -- close_on_exit = true, -- close the terminal window when the process exits
            close_on_exit = false, -- close the terminal window when the process exits
            -- shell = vim.o.shell, -- change the default shell
            shell = 'fish', -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                border = 'shadow', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
                width = 800,
                height = 500,
                winblend = 3,
                highlights = {
                    border = 'Normal',
                    background = 'Normal',
                },
            },
        })

        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
}
