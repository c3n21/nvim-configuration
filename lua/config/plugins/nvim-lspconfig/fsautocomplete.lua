local lspconfig = require'lspconfig'
local fsautocomplete = lspconfig.fsautocomplete

fsautocomplete.setup{
    cmd = {'dotnet',
        '/home/nezuko/Downloads/chrome/fsautocomplete.netcore/fsautocomplete.dll',
        '--background-service-enabled'
    }
}

vim.api.nvim_command([[
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp
]])

return fsautocomplete
