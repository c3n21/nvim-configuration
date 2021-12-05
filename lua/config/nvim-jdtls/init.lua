if not packer_plugins and not packer_plugins["nvim-jdtls"] then
    print("nvim-jdtls not installed")
    return nil
end


local coq = require "coq" -- add this
local jdtls = require "jdtls"
local system_config = require('config')

local workspace_root = os.getenv('HOME') .. '/.config/nvim-jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t')
local config = {
    cmd = {
        'jdtls.sh', workspace_root,
    },
    root_dir = jdtls.setup.find_root({'gradle.build', 'pom.xml', ".git"})
}

local current = system_config.completion.current
local fmt = string.format

if system_config.completion[current] == nil then
    error(fmt("completion framework '%s' not supported", current))
end

return system_config.completion[current]()
