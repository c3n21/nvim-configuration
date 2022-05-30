vim.o.path = vim.o.path .. "**"

vim.g.mapleader = " "
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    }
)
-- Grep rg
-- Use faster grep alternatives if possible
if vim.fn.executable 'rg' then
    vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
    vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
end

if vim.fn.has("persistent_undo") then
    -- create the directory and any parent directories
    local target_path = vim.fn.expand("~/.local/share/nvim/undo")
    if vim.fn.isdirectory(target_path) < 1 then
        vim.notify("Creating undo directory")
        vim.fn.mkdir(target_path, "p")
    end
    vim.o.undodir = target_path
end

vim.o.undofile = true
vim.opt.secure = true -- Disable autocmd etc for project local vimrc files.

vim.opt.fillchars = {
    vert = '▕', -- alternatives │
    fold = ' ',
    eob = ' ', -- suppress ~ at EndOfBuffer
    diff = '╱', -- alternatives = ⣿ ░ ─
    msgsep = '‾',
    foldopen = '▾',
    foldsep = '│',
    foldclose = '▸',
}

-----------------------------------------------------------------------------//
-- Folds {{{1
-----------------------------------------------------------------------------//
vim.opt.foldtext = 'v:lua.as.folds()'
vim.opt.foldopen = vim.opt.foldopen + 'search'
vim.opt.foldlevelstart = 0
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext =
--     [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
-- vim.wo.fillchars = "fold:\\"
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

-----------------------------------------------------------------------------//
-- Format Options {{{1
-----------------------------------------------------------------------------//
vim.opt.formatoptions = {
    ['1'] = true,
    ['2'] = true, -- Use indent from 2nd line of a paragraph
    q = true, -- continue comments with "gq"
    c = true, -- Auto-wrap comments using textwidth
    r = true, -- Continue comments when pressing Enter
    n = true, -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true, -- remove a comment leader when joining lines.
    -- Only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    v = true,
}

-----------------------------------------------------------------------------//
-- Diff {{{
-----------------------------------------------------------------------------//
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
vim.opt.diffopt = vim.opt.diffopt
    + {
        'vertical',
        'iwhite',
        'hiddenoff',
        'foldcolumn:0',
        'context:4',
        'algorithm:histogram',
        'indent-heuristic',
    }

vim.o.clipboard="unnamedplus"

--vim.opt.list = true -- invisible chars
--vim.opt.listchars = {
--  eol = nil,
--  tab = '  │',
----  tab = '| ',
--  extends = '›', -- Alternatives: … »
--  precedes = '‹', -- Alternatives: … «
--  trail = nil,--'•', -- BULLET (U+2022, UTF-8: E2 80 A2)
--}

vim.opt.autoindent = true --indent a new line the same amount as the line just typed
-----------------------------
-- Editor settings
-----------------------------
vim.opt.number = true -- add line numbers
vim.opt.relativenumber = true -- enable relative numbers

vim.opt.wildmode = {"longest,list"} -- completion

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.termguicolors = true

vim.opt.showmatch = true
vim.opt.mouse = "v"
vim.opt.hlsearch = true
vim.opt.pyx = 3
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.incsearch = true


vim.opt.tabstop=4 -- number of spaces for each tab
vim.opt.shiftwidth=4 -- number of space used for indenting using >> or <<
vim.opt.expandtab = true

-- vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts) not used
-- vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

-- vim.api.nvim_set_keymap('n', '<leader>cq', ':cclose <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>co', ':copen <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>cn', ':cnext <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>cN', ':cprevious <CR>', opts)

-- vim.api.nvim_set_keymap('n', '<leader>Cn', ':cnext <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>CN', ':cprevious <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>Co', ':lopen <CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>Cq', ':lclose <CR>', opts)

-- local maps = require("map")
-- local mode, mapping =  unpack(maps.buffer)
-- vim.api.nvim_set_keymap(mode, mapping, ":BufferLinePick<CR>", opts)

-- mode, mapping =  unpack(maps.buffer.n.close)
-- vim.api.nvim_set_keymap(mode, mapping, ":BufferLinePickClose<CR>", opts)
--

local _config = {
    mappings = {},
    plugins = {},
    enable_lsp = {},
    log_level = vim.log.levels.WARN,
    completion = {
        current = ""
    },

}

local function apply()
    local maps = _config.mappings
    for lhs, map in pairs(maps) do
        for rhs, map_opts in pairs(map) do
            vim.keymap.set(map_opts.modes, lhs, rhs, map_opts.opts)
        end
    end
end

return {
    ['setup'] = function (config)
        setmetatable(config.completion, {
            __index = function (_, key)
                return function (ls_config)
                    print(string.format("Completion framework '%s' not available", key))
                    return ls_config
                end
            end

        })

        _config = config
        apply()
    end,

    ['get_config'] = function ()
        return _config
    end
}
