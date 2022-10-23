vim.cmd('packadd plenary.nvim')

local function sanitize(plugin_name)
    local result = vim.split(plugin_name, '/', {
        plain = true,
        trimempty = true,
    })

    local sanitized_name = result[#result]

    sanitized_name = vim.fn.substitute(sanitized_name, '\\.', '_', 'g')

    return sanitized_name
end

local function generate_config(plugin_name)
    local path = require('plenary.path')

    local sane_plugin_name = sanitize(plugin_name)

    local plugin_path = path:new(vim.fn.stdpath('config'), 'lua', 'config', 'plugins', sane_plugin_name)

    local plugin_init = plugin_path:joinpath('init.lua')

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
