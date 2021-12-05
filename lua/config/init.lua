local system_config = {
    CONFIG_AVAILABLE_COMPLETION = {"nvim-cmp", "coq_nvim"},
    completion = {
        current = "nvim-cmp",
        ["nvim-cmp"] = function (config)
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            config["capabilities"] = capabilities
            return config
        end
        ,

        ["coq_nvim"] = function (config)
            local coq = require('coq')
            coq.lsp_ensure_capabilities(config)
            return config
        end
    }
}

system_config.completion.__index = function (self, key)
    return function (config)
        print(string.format("Completion framework '%s' not available", key))
        return config
    end
end

setmetatable(system_config.completion, system_config.completion)

return system_config
