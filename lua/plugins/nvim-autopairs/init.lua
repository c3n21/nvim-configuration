return {
    'windwp/nvim-autopairs',
    config = function()
        local npairs = require('nvim-autopairs')
        npairs.setup({
            disable_filetype = { 'TelescopePrompt' },
            ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
            enable_moveright = true,
            check_ts = true,
            disable_in_macro = false, -- disable when recording or executing a macro,
            enable_afterquote = true, -- add bracket pairs after quote,
            enable_check_bracket_line = true, --- check bracket in same line,
            map_bs = true, -- map the <BS> key,
            map_c_w = true, -- map <c-w> to delete an pair if possible,
        })

        local remap = vim.api.nvim_set_keymap

        _G.MUtils = {}

        MUtils.CR = function()
            if vim.fn.pumvisible() ~= 0 then
                if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                    return npairs.esc('<c-y>')
                else
                    return npairs.esc('<c-e>') .. npairs.autopairs_cr()
                end
            else
                return npairs.autopairs_cr()
            end
        end
        remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

        MUtils.BS = function()
            if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
                return npairs.esc('<c-e>') .. npairs.autopairs_bs()
            else
                return npairs.autopairs_bs()
            end
        end
        remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

        --- check ./lua/nvim-autopairs/rules/basic.lua
    end,
}
