" Set this. Airline will handle the rest.

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
"set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=8 
set softtabstop=0 
set expandtab 
set shiftwidth=8 
set smarttab
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

autocmd FileType json syntax match Comment +\/\/.\+$+

set t_Co=256
syntax on
colorscheme minimalist
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set list
set listchars=tab:>-

"""""""""""""""""""""""
"Plugins configuration"
"""""""""""""""""""""""

"MatchTagAlways
source ~/.config/nvim/config/plugins.conf.d/match_tag_always.vim

"vim-closetag
source ~/.config/nvim/config/plugins.conf.d/vim-closetag.vim

"cocvim
source ~/.config/nvim/config/plugins.conf.d/neoclide-cocvim.vim

"junegunn/fzf.vim
source ~/.config/nvim/config/plugins.conf.d/fzf.vim

"vista
source ~/.config/nvim/config/plugins.conf.d/vista.vim

"eleline
source ~/.config/nvim/config/plugins.conf.d/eleline.vim

"vim-signify
source ~/.config/nvim/config/plugins.conf.d/vim-signify.vim

"vim-buffet
source ~/.config/nvim/config/plugins.conf.d/vim-buffet.vim

"nnn
source ~/.config/nvim/config/plugins.conf.d/nnn.vim
