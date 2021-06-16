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

colorscheme gruvbox

let g:gruvbox_contrast_dark = 'hard'

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_invert_selection='0'
set background=dark

syntax on
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights()

"augroup lsp
"    au!
"    au FileType java lua require('jdtls').start_or_attach({cmd = {'nvim-jdtls.sh'}})
"augroup end
