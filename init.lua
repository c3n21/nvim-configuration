local fmt = string.format

local function reset()
    local ns = { 'packer', 'config', 'config.plugins.packer_nvim', 'settings', 'settings.map', 'utils' }
    for _, n in ipairs(ns) do
        package.loaded[n] = nil
    end
end

local function start()
    local fn = vim.fn
    local utils = require('utils')
    local printf = utils.printf

    local install_path = ''
    printf("Detected OS: '%s'", jit.os)
    if jit.os == 'Linux' then
        install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    else
        error(fmt("OS: '%s' not supported"))
    end

    if fn.empty(fn.glob(install_path)) > 0 then
        vim.notify(fmt("packer.nvim not installed: installing in '%s'", install_path), vim.log.levels.INFO)
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.notify("packer.nvim installed", vim.log.levels.INFO)

        vim.cmd([[packadd packer.nvim]])

        install_path = fn.stdpath('data') .. '/site/pack/packer/start/plenary.nvim'

        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/nvim-lua/plenary.nvim', install_path })
        vim.cmd([[packadd plenary.nvim]])
    end
end

reset()
start()

local success
local packer
local packer_config

local opts = { noremap = true, silent = true }
success, packer_config = pcall(require, 'config.plugins.packer_nvim')

if not success then
    vim.notify(fmt("Error loading packer's config: %s", vim.inspect(success)), vim.log.levels.WARN)
    packer_config = {}
end

success, packer = pcall(require, 'packer')

if not success then
    vim.notify(fmt('Error loading packer: %s', vim.inspect(success)), vim.log.levels.WARN)
else
    packer.startup(packer_config)
end

local undo_breakpoints = (function()
    local breakpoints = { ',', '.', '[', ']', '!', '?' }
    local mappings = {}
    for _, breakpoint in ipairs(breakpoints) do
        mappings[#mappings + 1] = {
            [breakpoint] = {
                [breakpoint .. '<c-g>u'] = {
                    modes = 'i',
                    opts = opts,
                },
            },
        }
    end

    return mappings
end)()

local settings_config = {
    enable_lsp = {
        'pyright',
        'tsserver',
        'clangd',
        'dartls',
        'ocamllsp',
        'intelephense',
        'rust_analyzer',
        -- "sumneko_lua" using lua-dev
        -- "fsautocomplete",
        -- "rnix",
        -- "efm"
    },
    log_level = vim.log.levels.WARN,
    CONFIG_AVAILABLE_COMPLETION = { 'nvim-cmp', 'coq_nvim' },
    completion = {
        current = 'nvim-cmp',
        ['nvim-cmp'] = function(config)
            local capabilities = require('cmp_nvim_lsp').update_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )
            config['capabilities'] = capabilities
            return config
        end,

        ['coq_nvim'] = function(config)
            local coq = require('coq')
            coq.lsp_ensure_capabilities(config)
            return config
        end,
    },
    mappings = {
        --[[
        -- Lines manipulation
        --]]
        ['<M-K>'] = {
            [':m-2 <CR>gv=gv'] = {
                modes = { 'x' },
                opts = opts,
            },
            [':<C-u>m-2<CR>=='] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<M-J>'] = {
            [":m'>+<CR>gv=gv"] = {
                modes = { 'x' },
                opts = opts,
            },
            [':<C-u>m+<CR>=='] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        --[[
        -- Registers manipulation
        --]]
        ['<C-c>'] = {
            ['"+y'] = {
                modes = { 'v' },
                opts = opts,
            },
        },
        --[[
        -- Undo break points
        --]]
        -- unpack(undo_breakpoints),
        ['<leader>b'] = {
            -- [":buffers<CR>"] = {
            --     modes = {"n"},
            --     opts = opts
            -- }
            [require('telescope.builtin').buffers] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<C-q>'] = {
            [':bd<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['gd'] = {
            [vim.lsp.buf.definition] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['K'] = {
            [vim.lsp.buf.hover] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['gi'] = {
            [vim.lsp.buf.implementation] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<C-k>'] = {
            [vim.lsp.buf.signature_help] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>D'] = {
            [vim.lsp.buf.type_definition] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>rn'] = {
            [vim.lsp.buf.rename] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        -- code_action = create_map("n", "<leader>ca", { cmd = vim.lsp.buf.code_action, opts = opts }),

        ['<leader>ca'] = {
            [vim.lsp.buf.code_action] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>d'] = {
            [vim.diagnostic.open_float] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['[d'] = {
            [vim.diagnostic.goto_prev] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        [']d'] = {
            [vim.diagnostic.goto_next] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>q'] = {
            [vim.diagnostic.setloclist] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>cq'] = {
            [':close<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>co'] = {
            [':copen<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        [']c'] = {
            [function()
                if vim.wo.diff then
                    return ']c'
                end
                vim.schedule(function()
                    require('gitsigns').next_hunk()
                end)
                return '<Ignore>'
            end] = {
                modes = { 'n' },
                opts = { expr = true },
            },
        },
        ['<leader>e'] = {
            [':Telescope file_browser<CR>'] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
            -- ['<cmd>CHADopen<cr>'] = {
            --     modes = {"n"},
            --     opts = { noremap = true, silent = true }
            -- }
        },
        ['[c'] = {
            [function()
                if vim.wo.diff then
                    return '[c'
                end
                vim.schedule(function()
                    require('gitsigns').prev_hunk()
                end)
                return '<Ignore>'
            end] = {
                modes = { 'n' },
                opts = { expr = true },
            },
        },
    },
}

---[[
-- Adding undo breakpoints mappings
--]]
settings_config.mappings = vim.tbl_extend('keep', settings_config.mappings, unpack(undo_breakpoints))

local settings

success, settings = pcall(require, 'settings')

if not success then
    vim.notify(fmt('Error loading settings: %s', vim.inspect(success)), vim.log.levels.WARN)
else
    settings.setup(settings_config)
end
