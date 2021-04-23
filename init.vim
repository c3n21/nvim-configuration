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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'

Plug 'tjdevries/astronauta.nvim'

"Install telescope
Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"UltiSnips
"Plug 'SirVer/ultisnips'

Plug 'sheerun/vim-polyglot'

"LSP diagnostics
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-trouble.nvim'

call plug#end()
