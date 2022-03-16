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
        ["<leader>b"] = {
            -- [":buffers<CR>"] = {
            --     modes = {"n"},
            --     opts = opts
            -- }
            [require('telescope.builtin').buffers] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<C-q>"] = {
            [":bd<CR>"] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["gD"] = {
            [vim.lsp.buf.declaration] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["gd"] = {
            [vim.lsp.buf.definition] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["K"] = {
            [vim.lsp.buf.hover] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["gi"] = {
            [vim.lsp.buf.implementation] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<C-k>"] = {
            [vim.lsp.buf.signature_help] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>D"] = {
            [vim.lsp.buf.type_definition] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>rn"] = {
            [vim.lsp.buf.rename] = {
                modes = {"n"},
                opts = opts
            }
        },
        -- code_action = create_map("n", "<leader>ca", { cmd = vim.lsp.buf.code_action, opts = opts }),

        ["<leader>ca"] = {
            [":Telescope lsp_code_actions<CR>"] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>d"] = {
            [vim.diagnostic.open_float] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["[d"] = {
            [vim.lsp.diagnostic.goto_prev] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["]d"] = {
            [vim.lsp.diagnostic.goto_next] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>q"] = {
            [vim.lsp.diagnostic.set_loclist] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>cq"] = {
            [":close<CR>"] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>co"] = {
            [":copen<CR>"] = {
                modes = {"n"},
                opts = opts
            }
        }
    }
}

system_config.completion.__index = function (_, key)
    return function (config)
        print(string.format("Completion framework '%s' not available", key))
        return config
    end
end

setmetatable(system_config.completion, system_config.completion)

return system_config
