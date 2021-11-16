colorscheme gruvbox

let g:gruvbox_contrast_dark = 'hard'

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_invert_selection='0'
set background=dark

syntax on

highlight Normal guibg=none
highlight NonText ctermfg=12 gui=bold guifg=#313136 guibg=none

set pastetoggle=<F3>

filetype plugin indent on   " allows auto-indenting depending on file type
filetype plugin on   " allows auto-indenting depending on file type

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
