"Mapping"

" nnoremap <NL> i<CR><ESC>

" Keep centered
nnoremap n nzzzv
nnoremap N Nzzzv
" nnoremap J mzJ`z

" Jumplist mutations
nnoremap <expr> k (v:count > 5? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5? "m'" . v:count : "") . 'j'
