call plug#begin('~/.local/share/nvim/plugged')
  "closetag for html
  Plug 'https://github.com/alvan/vim-closetag'
  Plug 'MaxMEllon/vim-jsx-pretty'
  
  "Color scheme
  Plug 'dikiaap/minimalist'
  Plug 'https://github.com/Valloric/MatchTagAlways'
 "" Plug 'scrooloose/nerdtree'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'},

  "Fuzzy search
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  
  "Session management with tmux
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-surround'

  "TagBar
  Plug 'liuchengxu/vista.vim'

  "Status line
  Plug 'liuchengxu/eleline.vim'

  "Show diffs
  Plug 'mhinz/vim-signify'

  "Beautify
  Plug 'ryanoasis/vim-devicons'

  "Tabs management
  Plug 'bagrat/vim-buffet'
  "vifm"
  Plug 'vifm/vifm.vim'
  Plug 'qpkorr/vim-bufkill'
call plug#end()
