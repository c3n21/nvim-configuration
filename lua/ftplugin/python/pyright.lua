return function()
    local util = require 'lspconfig/util'
    local root_files = {
        'setup.py',
        'pyproject.toml',
        'setup.cfg',
        'requirements.txt',
        '.git',
        'bufdir'
    }

    require'lspconfig'.pyright.setup{
        default_config = {
            root_dir = function(filename)
                return util.root_pattern(unpack(root_files))(filename) or
                    util.path.dirname(filename)
            end;
        };

    }
end
