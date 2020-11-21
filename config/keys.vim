"Mapping"

let g:mapleader = ' '
nnoremap <NL> i<CR><ESC>

"nnoremap <C-Tab> :tabprevious<CR>
"nnoremap <C-S-Tab> :tabnext<CR>
"nnoremap <silent> <C-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <silent> <C-S-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

"Create new file if not exist using gf
map <leader>gf :e <cfile><cr>
"map <C-O> :Vifm <cr>
"map <C-O> :leftabove vertical 40Vifm <cr>
"Pasting always the last element copied element
"nnoremap <leader>p p
"nnoremap p "0p
""""""""""""""""""""
" Lines manipulation
""""""""""""""""""""
xnoremap <M-K> :m-2 <CR>gv=gv
xnoremap <M-J> :m'>+<CR>gv=gv
nnoremap <M-J> :<C-u>m+<CR>==
nnoremap <M-K> :<C-u>m-2<CR>==

"""""""""""""""""""""
"Buffer manipulation
"""""""""""""""""""""
nmap <C-c> :BD <cr>

""""""""""""""""""""""""
"Registers manipulation
""""""""""""""""""""""""
vnoremap <C-c> "+y

""""""""""""""
"Split panels
""""""""""""""
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h


"Format JSON
nmap =j :%!python -m json.tool<CR>
