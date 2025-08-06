local npairs = require('nvim-autopairs')
npairs.setup({
    disable_filetype = { 'TelescopePrompt' },
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
    enable_moveright = true,
    check_ts = true,
    disable_in_macro = true, -- disable when recording or executing a macro,
    enable_afterquote = true, -- add bracket pairs after quote,
    enable_check_bracket_line = true, --- check bracket in same line,
    map_bs = true, -- map the <BS> key,
    map_c_w = true, -- map <c-w> to delete an pair if possible,
})
