"Mapping"

let g:mapleader = ' '
nnoremap <NL> i<CR><ESC>

"nnoremap <C-Tab> :tabprevious<CR>
"nnoremap <C-S-Tab> :tabnext<CR>
"nnoremap <silent> <C-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <silent> <C-S-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

"Create new file if not exist using gf
map <leader>gf :e <cfile><cr>
