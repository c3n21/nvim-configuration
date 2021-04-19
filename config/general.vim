" Set this. Airline will handle the rest.
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set pyx=3

set incsearch
set pastetoggle=<F3>
set autoread                "reaload buffer on change

set exrc
set hidden
set nowrap
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
syntax on                   " syntax highlighting
  
set encoding=utf-8
set fileencoding=utf-8

set background=dark
set termguicolors
let g:quantum_italics=1

set t_Co=256
syntax on
colorscheme minimalist
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

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

"""""""""""""""""""""""
"Plugins configuration"
"""""""""""""""""""""""

"cocvim
source ~/.config/nvim/config/plugins.conf.d/coc.vim

"junegunn/fzf.vim
source ~/.config/nvim/config/plugins.conf.d/fzf.vim

"eleline
source ~/.config/nvim/config/plugins.conf.d/eleline.vim

"vim-wintabs
source ~/.config/nvim/config/plugins.conf.d/vim-wintabs.vim

"ultisnips
source ~/.config/nvim/config/plugins.conf.d/ultisnips.vim

augroup INIT
    autocmd!
augroup end
