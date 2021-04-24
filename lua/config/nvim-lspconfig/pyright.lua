local util = require 'lspconfig/util'
local pyright = require'lspconfig'.pyright
local root_files = {
    'setup.py',
    'pyproject.toml',
    'setup.cfg',
    'requirements.txt',
    '.git',
    bufdir,
}

pyright.setup{
    default_config = {
        root_dir = function(filename)
            return util.root_pattern(unpack(root_files))(filename) or
                util.path.dirname(filename)
        end;
    };
}
