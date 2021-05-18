" Using lua functions
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>gb <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>
nnoremap <leader>gn <cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>
nnoremap <leader>gc <cmd>lua require'telescope.builtin'.git_commits{}<cr>
nnoremap <leader>gb <cmd>lua require'telescope.builtin'.git_commits{}<cr>
nnoremap <leader>l <cmd>lua require'telescope.builtin'.treesitter{}<cr>
nnoremap <leader>ff <cmd>lua require'telescope.builtin'.file_browser{}<cr>
