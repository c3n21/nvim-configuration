local config = require("config.nvim-jdtls")
if config == nil then
    return
end

local jdtls = require('jdtls')

jdtls.start_or_attach(config)
