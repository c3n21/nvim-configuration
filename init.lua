require("setup") -- download packer
local system_config = require('config')
local packer_config = require('config.packer')
local packer = require('packer')
packer.startup(packer_config)

require('settings')
-- Set colorscheme
vim.g.colors_name = 'gruvbox'
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection='0'
