"Mapping"

nnoremap <NL> i<CR><ESC>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/

"Create new file if not exist using gf
"map <leader>gf :e <cfile><cr>
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

""""""""""""""""""""""""
"Registers manipulation
""""""""""""""""""""""""
vnoremap <C-c> "+y

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Keep centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Jumplist mutations
nnoremap <expr> k (v:count > 5? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5? "m'" . v:count : "") . 'j'
