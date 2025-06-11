local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local function get_typescript_server_path(root_dir)
    local project_roots = vim.fs.find('node_modules', { path = root_dir, upward = true, limit = math.huge })
    for _, project_root in ipairs(project_roots) do
        local typescript_path = project_root .. '/typescript'
        local stat = vim.loop.fs_stat(typescript_path)
        if stat and stat.type == 'directory' then
            return typescript_path .. '/lib'
        end
    end
    return ''
end

return {
    capabilities = capabilities,
    on_new_config = function(config, new_root_dir)
        vim.print(config)
        if config.init_options and config.init_options.typescript and not config.init_options.typescript.tsdk then
            config.init_options.typescript.tsdk = get_typescript_server_path(config.root_dir)
        end
    end,
}
