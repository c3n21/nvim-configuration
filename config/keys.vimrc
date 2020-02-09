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

""""""""""""""
"Split panels
""""""""""""""
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h

"""""""""""""""
"Coc explorer
"""""""""""""""
map <F2> :CocCommand explorer 
      \ --width 30
      \ --sources=buffer+,file+
      \ --file-columns=git:selection:clip:diagnosticError:indent:icon:filename;fullpath;size;modified;readonly
      \<cr>
