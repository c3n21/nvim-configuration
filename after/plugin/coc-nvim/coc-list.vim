" grep word under cursor
"command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
"
"function! s:GrepArgs(...)
"  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
"        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
"  return join(list, "\n")
"endfunction
"
"" Keymapping for grep word under cursor with interactive mode
"nnoremap <silent> <Leader>lgw :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

"function! s:GrepFromSelected(type)
"  let saved_unnamed_register = @@
"  if a:type ==# 'v'
"    normal! `<v`>y
"  elseif a:type ==# 'char'
"    normal! `[v`]y
"  else
"    return
"  endif
"  let word = substitute(@@, '\n$', '', 'g')
"  let word = escape(word, '| ')
"  let @@ = saved_unnamed_register
"  execute 'CocList grep '.word
"endfunction
"
""mappings
"vnoremap <leader>lg :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
"nnoremap <leader>lg :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
nnoremap <silent> <space>lcw  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" show buffers
nnoremap <silent> <space>b  :<C-u>CocList buffers<CR>
"
"nnoremap <silent> <leader>lcw  :exe 'CocFzfList -I --normal --input='.expand('<cword>').' words'<CR>
