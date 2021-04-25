-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
print("Loading")
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
require('jdtls').start_or_attach({cmd = {'nvim-jdtls.sh'}, root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})})
--print(os.getenv('HOME'))
--print(vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t'))
--require('jdtls').start_or_attach({{
--            cmd = {
--                'nvim-jdtls.sh', 
--                os.getenv('HOME') .. '/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')},
--        root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})}
--    })
