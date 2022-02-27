local function reset()
    local ns = {"packer", "config", "config.packer_nvim", "settings", "settings.map"}
    for _, n in ipairs(ns) do
        package.loaded[n] = nil
    end
end
reset()
require("setup")
local system_config = require('config')
local packer_config = require('config.packer_nvim')
local packer = require('packer')
packer.startup(packer_config)

require('settings')
-- Set colorscheme
vim.g.colors_name = 'gruvbox'
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection='0'
