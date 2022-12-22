local lspconfig = require('lspconfig')
return {
    -- root_dir = lspconfig.util.root_pattern('composer.json'),
    root_dir = lspconfig.util.root_pattern('.git'),
    settings = {
        intelephense = {
            files = {
                maxSize = 1000000,
            },
            diagnostics = {
                undefinedProperties = true,
            },
        },
    },
}
