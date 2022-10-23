_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
    },
}
local success, _ = pcall(require, 'impatient')
local fmt = string.format
local luasnip
success, luasnip = pcall(require, 'luasnip')

vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'

local opts = { noremap = true, silent = true }

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
    enable_dap = {
        'php',
    },
    enable_lsp = {
        'pyright',
        'tsserver',
        'clangd',
        'dartls',
        'ocamllsp',
        'intelephense',
        'tailwindcss',
        -- 'rust_analyzer',
        -- "sumneko_lua" using lua-dev
        -- "fsautocomplete",
        -- "rnix",
        -- "efm"
    },
    log_level = vim.log.levels.WARN,
    completion = 'nvim-cmp',
    mappings = {
        --[[
        Lines manipulation
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
        Undo break points
        --]]
        ['<leader>bo'] = {
            [function()
                require('telescope.builtin').buffers({ only_cwd = vim.fn.haslocaldir() == 1 })
            end] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>bq'] = {
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
        ['gD'] = {
            [vim.lsp.buf.type_definition] = {
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
        ['<leader>lr'] = {
            [':Telescope lsp_references<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['H'] = {
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
        ['<leader>ca'] = {
            [vim.lsp.buf.code_action] = {
                modes = { 'n', 'v' },
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
        ['<leader>lq'] = {
            [':lclose<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },

        ['<leader>ldd'] = {
            [':Telescope diagnostics<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },

        ['<leader>lds'] = {
            [':Telescope lsp_document_symbols<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },

        ['<leader>lws'] = {
            [':Telescope lsp_dynamic_workspace_symbols<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },

        ['<leader>lo'] = {
            [':Telescope loclist<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        [']l'] = {
            [':lnext<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['[l'] = {
            [':lprev<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>qq'] = {
            [':cclose<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['<leader>qo'] = {
            --[[ [':copen<CR>'] = { ]]
            [':Telescope quickfix<CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        [']q'] = {
            [':cnext <CR>'] = {
                modes = { 'n' },
                opts = opts,
            },
        },
        ['[q'] = {
            [':cprevious <CR>'] = {
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
        --[[
        TABS
        --]]
        ['<leader>tn'] = {
            [':tabe %<CR>'] = {
                modes = { 'n' },

                opts = { noremap = true, silent = true },
            },
        },
        ['<c-l>'] = {
            [function()
                if luasnip.choice_active() then
                    luasnip.change_choice(1)
                end
            end] = {
                modes = { 'i', 's' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<c-j>'] = {
            [function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end] = {
                modes = { 'i', 's' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<c-k>'] = {
            [function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end] = {

                modes = { 'i', 's' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<leader>/'] = {
            [':HopPattern<cr>'] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<leader>w'] = {
            [':HopWord<cr>'] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<leader><leader>s'] = {
            ['<cmd> source ~/.config/nvim/lua/config/plugins/LuaSnip/init.lua <CR>'] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<leader><leader>f'] = {
            [vim.lsp.buf.format] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<leader><leader>i'] = {
            [':luafile ' .. os.getenv('MYVIMRC') .. '<CR>'] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
        },
        ['<leader>ng'] = {
            [':Neogit <CR>'] = {
                modes = { 'n' },
                opts = { noremap = true, silent = true },
            },
        },
    },
}

-- [[
-- Adding undo breakpoints mappings
-- ]]
settings_config.mappings = vim.tbl_extend('keep', settings_config.mappings, unpack(undo_breakpoints))

local settings

success, settings = pcall(require, 'settings')
if not success then
    vim.notify(fmt('Error loading settings: %s', vim.inspect(success)), vim.log.levels.WARN)
else
    settings.setup(settings_config)
end

--success, settings = pcall(require, 'packer_compiled')
--if not success then
--    vim.notify(fmt('Error loading packer_compiled: %s', vim.inspect(success)), vim.log.levels.WARN)
--end
