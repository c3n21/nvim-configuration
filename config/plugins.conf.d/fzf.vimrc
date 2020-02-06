" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
let $FZF_DEFAULT_OPTS = '--layout=reverse'
" Required:
" - width [float range [0 ~ 1]]
" - height [float range [0 ~ 1]]
"
" Optional:
" - xoffset [float default 0.0 range [0 ~ 1]]
" - yoffset [float default 0.0 range [0 ~ 1]]
" - highlight [string default 'Comment']: Highlight group for border
" - border [string default 'rounded']: Border style ('rounded' | 'sharp' | 'horizontal')
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)

    let opts = {
         \ 'relative': 'editor',
         \ 'row': height * 0.3,
         \ 'col': col + 30,
         \ 'width': width * 2 / 3,
         \ 'height': height / 2
         \ }

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    call setwinvar(win, '&winhl', 'Normal:Pmenu')

    setlocal
         \ buftype=nofile
         \ nobuflisted
         \ bufhidden=hide
         \ nonumber
         \ norelativenumber
         \ signcolumn=no
endfunction
