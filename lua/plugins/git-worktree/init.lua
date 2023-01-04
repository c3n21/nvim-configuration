return {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('git-worktree').setup({
            update_on_change = true, -- default: true,
            update_on_change_command = 'e .', -- default: "e .",
            clearjumps_on_change = true, -- default: true,
            autopush = false, -- default: false,
        })

        require('telescope').load_extension('git_worktree')

        vim.keymap.set(
            'n',
            '<leader>gw',
            require('telescope').extensions.git_worktree.git_worktrees,
            { noremap = true, silent = true }
        )

        vim.keymap.set(
            'n',
            '<leader>gc',
            require('telescope').extensions.git_worktree.create_git_worktree,
            { noremap = true, silent = true }
        )
    end,
}
