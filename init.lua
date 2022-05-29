local function reset()
	local ns = { "packer", "config", "config.plugins.packer_nvim", "settings", "settings.map", "utils" }
	for _, n in ipairs(ns) do
		package.loaded[n] = nil
	end
end

local function start()
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
end

reset()
start()

local opts          = { noremap=true, silent=true }
local packer_config = require("config.plugins.packer_nvim")
local packer        = require("packer")

packer.startup(packer_config)

local undo_breakpoints = (function ()
    local breakpoints = {",", ".", "[", "]", "!", "?"}
    local mappings = {}
    for _, breakpoint in ipairs(breakpoints) do
        mappings[#mappings+1] = {
            [breakpoint] = {
                [breakpoint .. "<c-g>u"] = {
                    modes = "i",
                    opts = opts
                }
            }
        }
    end

    return mappings
end)()

local settings_config = {
    plugins = {
        path = vim.fn.stdpath("config"),
    },
    enable_lsp = {
        "pyright",
        "tsserver",
        "clangd",
        "dartls",
        "ocamllsp",
        "intelephense",
        "rust_analyzer"
        -- "sumneko_lua" using lua-dev
        -- "fsautocomplete",
        -- "rnix",
        -- "efm"
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
        --[[
        -- Lines manipulation
        --]]
        ["<M-K>"] = {
            [":m-2 <CR>gv=gv"] = {
                modes = {"x"},
                opts = opts
            },
            [":<C-u>m-2<CR>=="] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<M-J>"] = {
            [":m'>+<CR>gv=gv"] = {
                modes = {"x"},
                opts = opts
            },
            [":<C-u>m+<CR>=="] = {
                modes = {"n"},
                opts = opts
            },
        },
        --[[
        -- Registers manipulation
        --]]
        ["<C-c>"] = {
            ['"+y'] = {
                modes = {"v"},
                opts = opts
            }
        },
        --[[
        -- Undo break points
        --]]
        -- unpack(undo_breakpoints),
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
            [vim.lsp.buf.code_action] = {
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
            [vim.diagnostic.goto_prev] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["]d"] = {
            [vim.diagnostic.goto_next] = {
                modes = {"n"},
                opts = opts
            }
        },
        ["<leader>q"] = {
            [vim.diagnostic.setloclist] = {
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
        },
        ["]c"] = {
            [function ()
                if vim.wo.diff then return ']c' end
                    vim.schedule(function() require("gitsigns").next_hunk() end)
                return '<Ignore>'
            end] = {
                modes = {"n"},
                opts = {expr = true}
            }
        },
        ["[c"] = {
            [function ()
                if vim.wo.diff then return '[c' end
                    vim.schedule(function() require("gitsigns").prev_hunk() end)
                return '<Ignore>'
            end] = {
                modes = {"n"},
                opts = {expr = true}
            }
        }
    }
}

---[[
-- Adding undo breakpoints mappings
--]]
settings_config.mappings = vim.tbl_extend("keep", settings_config.mappings, unpack(undo_breakpoints))

local settings = require("settings")
settings.setup(settings_config)

require("config.plugins.kanagawa_nvim")
vim.cmd("colorscheme kanagawa")
