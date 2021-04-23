call plug#begin('~/.local/share/nvim/plugged')
"Color scheme
Plug 'dikiaap/minimalist'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

"Session management with tmux
Plug 'tpope/vim-obsession'

Plug 'tpope/vim-surround'

"Status line
"Plug 'liuchengxu/eleline.vim'

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

set completeopt=menuone,noinsert,noselect
let g:completion_confirm_key = ""

imap <silent> <c-space> <Plug>(completion_trigger)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_sorting = "none"
let g:completion_trigger_on_delete = 1
lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
