-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
local packer = require('packer')

vim.g.coc_global_extensions = {
    'coc-json',
    'coc-git',
    'coc-pairs',
    'coc-pyright',
    'coc-sumneko-lua',
    'coc-clangd',
    'coc-explorer'
}

return packer.startup({
    function(use)
        -- Packer can manage itself
        --use 'wbthomason/packer.nvim'
        use {
            'c3n21/packer.nvim',
            branch = 'snapshot',
        }

        use {
            'neoclide/coc.nvim',
            branch = 'release',
            disable = true,
            --requires = coc_extensions
        }

        use {
            'jbyuki/one-small-step-for-vimkind',
            disable = true,
            config = [[require('config.nvim-dap')]]
        }

        use {
            'ThePrimeagen/git-worktree.nvim',
            config = [[require('config.git-worktree')]]
        }

        use {
            'dikiaap/minimalist',
            disable = true
        }

        use {
            'morhetz/gruvbox',
            disable = false
        }

----------------------------
--      nvim-lsp
----------------------------
        use {
            'ms-jpq/coq_nvim',
            branch = 'coq',
            config = [[require('config.coq_nvim')]],
            disable = false
        }

        use {
            'ms-jpq/coq.artifacts',
            branch = 'artifacts',
            disable = false
        }

        use {
            'ms-jpq/chadtree',
            config = [[require('config.chadtree')]],
            branch = 'chad',
            run = 'python3 -m chadtree deps'
        }

        use {
            'mfussenegger/nvim-dap',
            disable = false,
        }

        use {
            'windwp/nvim-autopairs',
            disable = false,
            config = [[require('config.nvim-autopairs')]]
        }

        use {
            'mfussenegger/nvim-jdtls',
            disable = false,
            config = [[require('config.nvim-jdtls')]],
            ft = "java"
        }

        use {
            'glepnir/lspsaga.nvim',
            disable = true,
            config = [[require('config.lspsaga')]]
        }

        use {
            'neovim/nvim-lspconfig',
            disable = false,
            config = [[require('config.nvim-lspconfig')]]
        }

        use {
            'nvim-lua/completion-nvim',
            disable = true
        }

        use {
            'hrsh7th/nvim-compe',
            disable = true,
            config = [[require('config.nvim-compe')]],
            requires = {
                {'hrsh7th/vim-vsnip'},
            }
        }

        use {
            'tpope/vim-obsession'
        }

        use {
            'tpope/vim-surround'
        }

        -- use 'liuchengxu/eleline.vim'

        use {
            'nvim-treesitter/nvim-treesitter',
            config = [[require('config.nvim-treesitter')]],
        }

        use {
            'nvim-treesitter/nvim-treesitter-refactor',
            config = [[require('config.nvim-treesitter-refactor')]]
        }

        use {
            'nvim-treesitter/nvim-treesitter-textobjects',
            requires = { {'nvim-treesitter/nvim-treesitter'} }
        }

        use 'romgrk/nvim-treesitter-context'

        use {
            'glacambre/firenvim',
            run = function() vim.fn['firenvim#install'](0) end,
            disable = true
        }

        use {
            'tjdevries/astronauta.nvim',
            disable = true
        }

        use {
            'nvim-telescope/telescope.nvim',
            config = [[require('config.telescope')]],
            requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
        }

        -- UltiSnips
        -- use 'SirVer/ultisnips'

        use {
            'sheerun/vim-polyglot',
            --        ft = {'fsharp'},
            disable = false
        }

        use {
            'tpope/vim-fugitive'
        }

        use {
            'akinsho/nvim-bufferline.lua',
            config = [[require('config.nvim-bufferline')]]
        }

        use {
            'Yggdroot/indentLine',
            config = [[require('config.indentLine')]],
        }

        use {
            'mbbill/undotree',
            config = [[require('config.undotree')]]
        }

        use {
            'tpope/vim-sleuth',
            disable = true
        }

        use {
            'tpope/vim-repeat'
        }

        use {
            'KabbAmine/zeavim.vim',
            disable = false
        }

        use {
            "terrortylor/nvim-comment",
            config = function ()
                    require('nvim_comment').setup({
                    -- Linters prefer comment and line to have a space in between markers
                    marker_padding = true,
                    -- should comment out empty or whitespace only lines
                    comment_empty = false,
                    -- Should key mappings be created
                    create_mappings = true,
                    -- Normal mode mapping left hand side
                    line_mapping = "gcc",
                    -- Visual/Operator mapping left hand side
                    operator_mapping = "gc",
                    -- Hook function to call before commenting takes place
                    hook = nil})
            end
        }

        -- Navigation

        use {
            "ThePrimeagen/harpoon",
            config = function ()
                require("harpoon").setup({
                    global_settings = {
                        save_on_toggle = false,
                        save_on_change = true,
                        enter_on_sendcmd = false,
                    },
                    project = {}
                })

                vim.api.nvim_set_keymap(
                    'n','<leader>af',
                    '<cmd> lua require("harpoon.mark").add_file() <CR>',
                    { noremap = true, silent = true }
                )

                vim.api.nvim_set_keymap(
                    'n','<leader>m',
                    '<cmd> lua require("harpoon.ui").toggle_quick_menu() <CR>',
                    { noremap = true, silent = true }
                )

                vim.api.nvim_set_keymap(
                    'n','<leader>t',
                    '<cmd> lua require("harpoon.term").gotoTerminal(1) <CR>',
                    { noremap = true, silent = true }
                )

            end
        }

-------------------------
-- Markdown for NeoVim --
-------------------------

        use {
            'ellisonleao/glow.nvim',
            disable = true
        }

        use {
            'vimwiki/vimwiki',
            disable = false,
            config = function ()
                vim.g.vimwiki_list = {
                    {
                        ["path"] = "~/Downloads/github/cryptography.git/main/notes/",
                        ["syntax"] = "markdown",
                        ["ext"] = ".md"
                    }
                }

                vim.g.vimwiki_markdown_link_ext = 1
            end
        }

        use {
            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim'
            },
            config = function()
                require("gitsigns").setup {
                    signcolumn = true,
                    current_line_blame = true,
                    current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                        delay = 500,
                    }
                }
            end
            -- tag = 'release' -- To use the latest release
        }

-- Utils
    use {
        'sychen52/smart-term-esc.nvim',
        config = function ()
                require('smart-term-esc').setup{
                    key='<Esc>',
                    except={'nvim', 'fzf'}
                }
                 end
    }

    end, config = {snapshot = nil} })
