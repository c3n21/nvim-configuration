" Set this. Airline will handle the rest.
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set pyx=3

set incsearch
set pastetoggle=<F3>
set autoread                "reaload buffer on change

set hidden
"set nowrap
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set rnu

set tabstop=4 
set softtabstop=0 
set expandtab 
set shiftwidth=4 
set autoindent              " indent a new line the same amount as the line just typed

set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allows auto-indenting depending on file type
  
set encoding=utf-8
set fileencoding=utf-8

set background=dark
set termguicolors
let g:quantum_italics=1

set t_Co=256
"set autochdir
let g:netrw_liststyle=3
