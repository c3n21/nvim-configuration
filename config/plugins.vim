call plug#begin('~/.local/share/nvim/plugged')
"closetag for html
Plug 'alvan/vim-closetag'
Plug 'MaxMEllon/vim-jsx-pretty'

"Color scheme
Plug 'dikiaap/minimalist'
Plug 'Valloric/MatchTagAlways'

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
"Plug 'zefei/vim-wintabs'
"Plug 'zefei/vim-wintabs-powerline'

"UltiSnips
Plug 'SirVer/ultisnips'

"Buffer management
"Plug 'qpkorr/vim-bufkill'

"nginx syntax highlight
Plug 'chr4/nginx.vim'

Plug 'jackguo380/vim-lsp-cxx-highlight'

call plug#end()
