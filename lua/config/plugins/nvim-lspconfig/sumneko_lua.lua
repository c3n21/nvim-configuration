local lspconfig = require('lspconfig')
local coq = require('coq') -- add this
local sumneko_lua = lspconfig.sumneko_lua
local system_name = ''
if vim.fn.has('mac') == 1 then
    system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
    system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
    system_name = 'Windows'
else
    system_name = 'unknown'
end

local sumneko_root_path = '/usr/lib/lua-language-server'
local sumneko_binary = '/bin/lua-language-server'
local path = vim.tbl_extend(
    'keep',
    vim.split(package.path, ';'),
    {
        'lua/?.lua',
        'lua/?/init.lua',
    },
    -- vim.fn.expand('$VIMRUNTIME/lua/?.lua'),
    -- vim.fn.expand('$VIMRUNTIME/lua/vim/?.lua'), }
    vim.fn.expand('$VIMRUNTIME/lua/**/*.lua', false, true)
)

-- local library = vim.tbl_extend("keep", {
--     vim.fn.expand('$VIMRUNTIME/lua'),
--     vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
--     -- [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--     -- [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
-- }, vim.api.nvim_get_runtime_file("", true))
-- local library = vim.tbl_map(function (lib)
--     return {[lib] = true}
-- end, vim.api.nvim_list_runtime_paths())
local library = {
    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
}

for _, runtime_path in pairs(vim.api.nvim_list_runtime_paths()) do
    library[runtime_path] = true
end

sumneko_lua.setup(coq.lsp_ensure_capabilities({
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    filetypes = { 'lua', 'vim' },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                -- path = path,
                path = path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = library,
                -- library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}))
return sumneko_lua
