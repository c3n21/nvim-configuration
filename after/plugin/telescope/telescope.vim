" Using lua functions
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>ht <cmd>lua require('telescope.builtin').help_tags()<cr>
"nnoremap <leader>gw <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>
"nnoremap <leader>gn <cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>
"nnoremap <leader>gc <cmd>lua require'telescope.builtin'.git_commits{}<cr>
"nnoremap <leader>gb <cmd>lua require'telescope.builtin'.git_bcommits{}<cr>
nnoremap <leader>l <cmd>lua require'telescope.builtin'.treesitter{}<cr>
"nnoremap <C-q> :Telescope quickfix <cr>
"nnoremap <leader>fb <cmd>lua require'telescope.builtin'.file_browser{}<cr>
