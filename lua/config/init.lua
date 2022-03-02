local create_map = require('utils').create_map

local opts = { noremap=true, silent=true }

local system_config = {
    plugins = {
        path = vim.fn.stdpath("config"),
    },
    log_level = vim.log.levels.WARN,
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
    },
    mappings = {
        buffer = {
            list = create_map("n", "<leader>b", {cmd = ":buffers<CR>", opts = opts}),
            close = create_map("n", "<C-q>", {cmd = ":bd<CR>", opts = opts})
        },
        lsp_buf = {
            declaration = create_map("n", "gD", { cmd = vim.lsp.buf.declaration, opts = opts}),
            definition = create_map("n", "gd", { cmd = vim.lsp.buf.definition, opts = opts}),
            hover = create_map("n", "K", { cmd = vim.lsp.buf.hover, opts = opts}),
            implementation = create_map("n", "gi", { cmd = vim.lsp.buf.implementation, opts = opts }),
            signature_help = create_map("n", "<C-k>", { cmd = vim.lsp.buf.signature_help, opts = opts}),
            type_definition = create_map("n", "<leader>D", { cmd = vim.lsp.buf.type_definition, opts = opts}),
            rename = create_map("n", "<leader>rn", { cmd = vim.lsp.buf.rename, opts = opts }),
            code_action = create_map("n", "<leader>ca", { cmd = vim.lsp.buf.code_action, opts = opts }),
        },
        lsp_diagnostic = {
            open_float = create_map("n", "<leader>d", { cmd = vim.diagnostic.open_float, opts = opts }),
            goto_prev = create_map("n", "[d", { cmd = vim.lsp.diagnostic.goto_prev, opts = opts }),
            goto_next = create_map("n", "]d", { cmd = vim.lsp.diagnostic.goto_next, opts = opts }),
            set_loclist = create_map("n", "<leader>q", { cmd = vim.lsp.diagnostic.set_loclist, opts = opts } )
        },
        quickfix = {
            close = create_map("n", "<leader>cq", { cmd = ":close<CR>", opts = opts}),
            open = create_map("n", "<leader>co", { cmd = ":copen<CR>", opts = opts}),
        }

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
