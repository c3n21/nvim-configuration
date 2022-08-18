local setup = function(config)
    local coq = require('coq')
    coq.lsp_ensure_capabilities(config)
    return config
end
return setup
