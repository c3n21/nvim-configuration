"Persistent undo
if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.local/share/nvim/undo')    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif    " point Vim to the defined undo directory.
    let &undodir = target_path    " finally, enable undo persistence.
    set undofile
endif

syntax on
colorscheme gruvbox
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
