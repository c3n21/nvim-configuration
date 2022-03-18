local function reset()
    local ns = {"packer", "config", "config.plugins.packer_nvim", "settings", "settings.map", "utils"}
    for _, n in ipairs(ns) do
        package.loaded[n] = nil
    end
end
reset()
require("setup")
local system_config = require('config')
local packer_config = require('config.plugins.packer_nvim')
local packer = require('packer')
packer.startup(packer_config)
require('settings')

require('config.plugins.kanagawa_nvim')
vim.cmd("colorscheme kanagawa")
