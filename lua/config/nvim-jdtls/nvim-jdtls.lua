-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
--require('jdtls').start_or_attach({
--    cmd = {
--        'nvim-jdtls.sh',
----        vim.fn.getenv('WORKSPACE') .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')
--    },
--    root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml', '.git'})
--})

--require('jdtls').start_or_attach({{
--            cmd = {
--                'nvim-jdtls.sh',
--                os.getenv('HOME') .. '/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')},
--        root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})}
--    })
return require('jdtls').start_or_attach({
    cmd = {
        'nvim-jdtls.sh',
    },
    root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml', '.git'})
})
