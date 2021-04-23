"set completeopt=menuone,noinsert,noselect
"let g:completion_confirm_key = ""
"
"imap <tab> <Plug>(completion_smart_tab)
"imap <s-tab> <Plug>(completion_smart_s_tab)
"imap <silent> <c-space> <Plug>(completion_trigger)
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"let g:completion_sorting = "none"
"let g:completion_trigger_on_delete = 1
