call plug#begin('~/.local/share/nvim/plugged')
"Color scheme
Plug 'dikiaap/minimalist'

Plug 'neoclide/coc.nvim', {'branch': 'release'},

"Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Session management with tmux
Plug 'tpope/vim-obsession'

Plug 'tpope/vim-surround'

"Status line
Plug 'liuchengxu/eleline.vim'

"Beautify
Plug 'ryanoasis/vim-devicons'

"Tabs management
Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'

"UltiSnips
"Plug 'SirVer/ultisnips'

Plug 'sheerun/vim-polyglot'

call plug#end()
