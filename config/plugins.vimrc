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
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  "Session management with tmux
  Plug 'tpope/vim-obsession'
  "Shortcut to replace quickly parenthesis
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
call plug#end()

"""""""""""""""""""""""
"Plugins configuration"
"""""""""""""""""""""""
"TagBar
"source ~/.config/nvim/config/plugins.conf.d/tagbar.vimrc

"MatchTagAlways
source ~/.config/nvim/config/plugins.conf.d/match_tag_always.vimrc

"vim-closetag
source ~/.config/nvim/config/plugins.conf.d/vim-closetag.vimrc

"cocvim
source ~/.config/nvim/config/plugins.conf.d/neoclide-cocvim.vimrc

"junegunn/fzf.vim
source ~/.config/nvim/config/plugins.conf.d/fzf.vimrc

"nerdtree
"source ~/.config/nvim/config/plugins.conf.d/nerdtree.vimrc

"vista
source ~/.config/nvim/config/plugins.conf.d/vista.vimrc

"eleline
source ~/.config/nvim/config/plugins.conf.d/eleline.vimrc

"vim-signify
source ~/.config/nvim/config/plugins.conf.d/vim-signify.vimrc

"vim-buffet
source ~/.config/nvim/config/plugins.conf.d/vim-buffet.vimrc

"vifm
source ~/.config/nvim/config/plugins.conf.d/vifm.vimrc
