nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>
"g:buffet_max_plug -> numero massimo di buffet

"Configuration

"g:buffet_always_show_tabline - if set to 0, the tabline will only be shown if there is more than one buffer or tab open.
let g:buffet_always_show_tabline = 0

"g:buffet_powerline_separators - if set to 1, use powerline separators in between buffers and tabs in the tabline (see the first screenshot).
let g:buffet_powerline_separators = 1

"g:buffet_separator - the character to be used for separating items in the tabline.
let g:buffet_separator = ""

"g:buffet_show_index - if set to 1, show index before each buffer name. Index is useful for switching between buffers quickly.
let g:buffet_show_index = 1

"g:buffet_max_plug - the maximum number of <Plug>BuffetSwitch provided. Mapping will be disabled if the option is set to 0.
let g:buffet_max_plug = 10

"g:buffet_use_devicons - if set to 1 and vim-devicons plugin is installed, show file type icons for each buffer in the tabline. If the vim-devicons plugin is not present, the option will automatically default to 0.
let g:buffet_use_devicons = 1

"g:buffet_tab_icon - the character to be used as an icon for the tab items in the tabline.
let g:buffet_tab_icon = "#"

"g:buffet_new_buffer_name - the character to be shown as the name of a new buffer.
let g:buffet_new_buffer_name = "*"

"g:buffet_modified_icon - the character to be shown by the name of a modified buffer. Default:
let g:buffet_modified_icon = "+"

"g:buffet_left_trun_icon - the character to be shown by the count of truncated buffers on the left.
let g:buffet_left_trunc_icon = "<"

"g:buffet_right_trun_icon - the character to be shown by the count of truncated buffers on the right.
let g:buffet_right_trunc_icon = ">"



"Style
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
