set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'readonly', 'filename', 'modified', 'method', 'cocstatus', 'git'] 
"      \           ],
"      \   'right': [ [ 'git']
"      \ ]
"      \ },
"      \ 'component_function': {
"      \   'method': 'NearestMethodOrFunction'
"      \ },
"      \ }
"
