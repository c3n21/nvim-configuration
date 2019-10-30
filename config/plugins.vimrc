call plug#begin('~/.local/share/nvim/plugged')
	Plug 'shawncplus/phpcomplete.vim'
	Plug 'https://github.com/alvan/vim-closetag'
	Plug 'mxw/vim-jsx'
	Plug 'pangloss/vim-javascript'
	Plug 'dikiaap/minimalist'
	Plug 'https://github.com/dense-analysis/ale'
  	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
	Plug 'jiangmiao/auto-pairs'
	Plug 'https://github.com/Valloric/MatchTagAlways'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'scrooloose/nerdtree'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
call plug#end()
