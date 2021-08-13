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
end

vim.opt.secure = true -- Disable autocmd etc for project local vimrc files.
vim.opt.exrc = true -- Allow project local vimrc files example .nvimrc see :h exrc
