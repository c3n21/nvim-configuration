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
nnoremap <NL> i<CR><ESC>

"MatchTagAlways Options

	let g:mta_filetypes = {
		\ 'html' : 1,
		\ 'xhtml' : 1,
		\ 'xml' : 1,
		\ 'jinja' : 1,
		\ 'javascript.jsx' : 1,
		\}

"vim-closetag Options


	" filenames like *.xml, *.html, *.xhtml, ...
	" These are the file extensions where this plugin is enabled.
	"
	let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'

	" filenames like *.xml, *.xhtml, ...
	" This will make the list of non-closing tags self-closing in the specified files.
	"
	let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'

	" filetypes like xml, html, xhtml, ...
	" These are the file types where this plugin is enabled.
	"
	let g:closetag_filetypes = 'html,xhtml,phtml'

	" filetypes like xml, xhtml, ...
	" This will make the list of non-closing tags self-closing in the specified files.
	"
	let g:closetag_xhtml_filetypes = 'xhtml,jsx'

	" integer value [0|1]
	" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
	"
	let g:closetag_emptyTags_caseSensitive = 1

	" dict
	" Disables auto-close if not in a "valid" region (based on filetype)
	"
	let g:closetag_regions = {
		\ 'typescript.tsx': 'jsxRegion,tsxRegion',
		\ 'javascript.jsx': 'jsxRegion',
		\ }

	" Shortcut for closing tags, default is '>'
	"
	let g:closetag_shortcut = '>'

	" Add > at current position without closing the current tag, default is ''
	"
	let g:closetag_close_shortcut = '<leader>>'

	"nnoremap <C-Tab> :tabprevious<CR>
	"nnoremap <C-S-Tab> :tabnext<CR>
	"nnoremap <silent> <C-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
	"nnoremap <silent> <C-S-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
