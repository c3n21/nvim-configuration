command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

" `code_action` is a superset of vim.lsp.buf.code_action and you'll be able to
" use this mapping also with other language servers
nnoremap <A-CR> <Cmd>lua require('jdtls').code_action()<CR>
vnoremap <A-CR> <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
nnoremap <leader>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>

nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>

nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>

vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>


" If using nvim-dap
" This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>

