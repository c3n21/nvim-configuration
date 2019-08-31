call plug#begin('~/.local/share/nvim/plugged')

	Plug 'mxw/vim-jsx'
	Plug 'pangloss/vim-javascript'
	Plug 'dikiaap/minimalist'
	Plug 'https://github.com/dense-analysis/ale'
  	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

call plug#end()


" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

set background=dark
set termguicolors
let g:quantum_italics=1

"Mapping"

let g:mapleader = ' '

