local path_separator

if jit.os == 'Windows' then
    path_separator = '\\'
else
    path_separator = '/'
end

local function sanitize(plugin_name)
    local result = vim.split(plugin_name, '/', {
        plain = true,
        trimempty = true,
    })

    local sanitized_name = result[#result]

    sanitized_name = vim.fn.substitute(sanitized_name, '\\.', '_', 'g')

    return sanitized_name
end

---comment
---@param entries any
---@return string
local function join_paths(entries)
    local joined_path = table.remove(entries, 1)

    for _, entry in ipairs(entries) do
        joined_path = joined_path .. path_separator .. entry
    end

    return joined_path
end

local function generate_config(plugin_name)
    local sane_plugin_name = sanitize(plugin_name)

    local plugin_path = join_paths({
        vim.fn.stdpath('config'),
        'lua',
        'config',
        'plugins',
        sane_plugin_name,
    })

    local plugin_init = join_paths({ plugin_path, 'init.lua' })

    if vim.fn.filereadable(tostring(plugin_init)) == 0 then
        vim.fn.mkdir(tostring(plugin_path), 'p')
        vim.fn.writefile({}, tostring(plugin_init))
    end

    return [[require('config.plugins.]] .. sane_plugin_name .. [[')]]
end

return {
    plugins = {
        generate_config = generate_config,
        sanitize = sanitize,
    },
}
