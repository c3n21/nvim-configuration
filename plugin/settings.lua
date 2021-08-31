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
--vim.opt.foldtext = 'v:lua.as.folds()'
vim.opt.foldopen = vim.opt.foldopen + 'search'
vim.opt.foldlevelstart = 3
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'

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
-- Diff {{{1
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

vim.opt.list = true -- invisible chars
vim.opt.listchars = {
  eol = nil,
  tab = '⣿ ',
--  tab = '| ',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = nil,--'•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

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
