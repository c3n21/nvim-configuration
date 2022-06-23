local settings = require('settings')
local dap      = require('dap')
local _config = settings.get_config()

for _, language in ipairs(_config.enable_dap) do
    local dap_configuration = require('config.plugins.nvim-dap.' .. language)
    for key, conf in pairs(dap_configuration) do
        dap[key][language] = conf
    end
end
