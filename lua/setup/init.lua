local fn = vim.fn
local utils = require('utils')
local printf = utils.printf
local fmt = string.format

local install_path = ""
printf("Detected OS: '%s'", jit.os)
if jit.os == "Linux" then
    install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
else
    error(fmt("OS: '%s' not supported"))
end

if fn.empty(fn.glob(install_path)) > 0 then
    printf("packer.nvim not installed: installing in '%s'", install_path)
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("packer.nvim installed")

    vim.cmd([[packadd packer.nvim]])
end
