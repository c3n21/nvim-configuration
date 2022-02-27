local log_level  = 'trace' --'warn'

vim.g.coc_global_extensions = {
    'coc-json',
    'coc-git',
    'coc-pairs',
    'coc-pyright',
    'coc-sumneko-lua',
    'coc-clangd',
    'coc-explorer'
}
local function sanitize(plugin_name)
    local result = vim.split(plugin_name, "/", {
        plain = true,
        trimempty = true
    })

    local sanitized_name = result[#result]

    sanitized_name = vim.fn.substitute(sanitized_name, "\\.", "_", "g")

    return sanitized_name
end

local function generate_config(plugin_name)
    local path = require("plenary.path")

    local sane_plugin_name = sanitize(plugin_name)

    local plugin_path = path:new(
    vim.fn.stdpath("config"),
    "lua",
    "config",
    sane_plugin_name
    )

    local plugin_init = plugin_path:joinpath("init.lua")

    if vim.fn.filereadable(tostring(plugin_init)) == 0 then
        vim.fn.mkdir(tostring(plugin_path), "p")
        vim.fn.writefile({}, tostring(plugin_init))
    end

    return [[require('config.]].. sane_plugin_name .. [[')]]
end

local config =
{
    {
        -- Packer can manage itself
        {
            'wbthomason/packer.nvim'
        },

        {
            'jbyuki/one-small-step-for-vimkind',
            disable = true,
            config = [[require('config.nvim-dap')]]
        },

        {
            'ThePrimeagen/git-worktree.nvim',
            disable = true,
            config = [[require('config.git-worktree')]]
        },

        {
            'morhetz/gruvbox',
            disable = false
        },

        -------------------------
        --- Completion Engine ---
        -------------------------

        {
            'neoclide/coc.nvim',
            branch = 'release',
            disable = true,
        },

        {
            'ms-jpq/coq_nvim',
            branch = 'coq',
            config = [[require('config.coq_nvim')]],
            opt = true,
            disable = false,
        },

        {
            'hrsh7th/nvim-cmp',
            disable = false,
            config = [[require('config.nvim-cmp')]],
            requires = {
                {'hrsh7th/vim-vsnip'},
                {'hrsh7th/cmp-nvim-lsp'}
            }
        },

        ----------------------------
        --      nvim-lsp
        ----------------------------
        {
            'scalameta/nvim-metals',
            config = [[require('config.nvim-metals')]],
            requires = { "nvim-lua/plenary.nvim" }
        },

        {
            'ms-jpq/coq.artifacts',
            branch = 'artifacts',
            disable = false
        },

        {
            'ms-jpq/chadtree',
            config = [[require('config.chadtree')]],
            branch = 'chad',
            run = 'python3 -m chadtree deps'
        },

        {
            'mfussenegger/nvim-dap',
            disable = false,
        },

        {
            'windwp/nvim-autopairs',
            disable = false,
            config = [[require('config.nvim-autopairs')]]
        },

        {
            'mfussenegger/nvim-jdtls',
            disable = false,
            ft = "java"
        },

        {
            'glepnir/lspsaga.nvim',
            disable = true,
            config = [[require('config.lspsaga')]]
        },

        {
            'neovim/nvim-lspconfig',
            disable = false,
        },

        {
            'folke/lua-dev.nvim',
            disable = false,
        },

        {
            'tpope/vim-obsession'
        },

        {
            'tpope/vim-surround'
        },

        {
            'nvim-treesitter/nvim-treesitter',
            config = [[require('config.nvim-treesitter')]],
        },

        {
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter',
            config = [[require('config.nvim-treesitter-refactor')]],
            require = {
                'nvim-treesitter/nvim-treesitter',
                config = [[require('config.nvim-treesitter')]],
            }
        },

        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
            requires = {
                {
                    'nvim-treesitter/nvim-treesitter',
                    config = [[require('config.nvim-treesitter')]],
                }
            },
            disable = true
        },

        {
            'romgrk/nvim-treesitter-context',
            after = 'nvim-treesitter',
            requires = {
                {
                    'nvim-treesitter/nvim-treesitter',
                    config = [[require('config.nvim-treesitter')]],
                }
            }
        },

        {
            'nvim-telescope/telescope.nvim',
            disable = false,
            config = [[require('config.telescope')]],
            requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
        },

        {
            'tpope/vim-fugitive'
        },

        {
            'akinsho/bufferline.nvim',
            config = [[require('config.nvim-bufferline')]]
        },

        {
            'lukas-reineke/indent-blankline.nvim',
            config = [[require('config.indent-blankline')]]
        },

        {
            'mbbill/undotree',
            config = [[require('config.undotree')]]
        },

        {
            'tpope/vim-sleuth',
            disable = false
        },

        {
            'tpope/vim-repeat'
        },

        {
            'KabbAmine/zeavim.vim',
            disable = false
        },

        {
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
            },

            -- Navigation

            {
                "ThePrimeagen/harpoon",
                disable = true,
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
            },

            -------------------------
            -- Markdown for NeoVim --
            -------------------------

            {
                'iamcco/markdown-preview.nvim',
                disable = false,
                run = function ()
                    vim.fn['mkdp#util#install']()
                end,
                config = function ()
                    -- set to 1, nvim will open the preview window after entering the markdown buffer
                    -- default: 0
                    vim.g.mkdp_auto_start = 0

                    -- set to 1, the nvim will auto close current preview window when change
                    -- from markdown buffer to another buffer
                    -- default: 1
                    vim.g.mkdp_auto_close = 1

                    -- set to 1, the vim will refresh markdown when save the buffer or
                    -- leave from insert mode, default 0 is auto refresh markdown as you edit or
                    -- move the cursor
                    -- default: 0
                    vim.g.mkdp_refresh_slow = 0

                    -- set to 1, the MarkdownPreview command can be use for all files,
                    -- by default it can be use in markdown file
                    -- default: 0
                    vim.g.mkdp_command_for_global = 0

                    -- set to 1, preview server available to others in your network
                    -- by default, the server listens on localhost (127.0.0.1)
                    -- default: 0
                    vim.g.mkdp_open_to_the_world = 0

                    -- use custom IP to open preview page
                    -- useful when you work in remote vim and preview on local browser
                    -- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
                    -- default empty
                    vim.g.mkdp_open_ip = ''

                    -- specify browser to open preview page
                    -- default: ''
                    vim.g.mkdp_browser = ''

                    -- set to 1, echo preview page url in command line when open preview page
                    -- default is 0
                    vim.g.mkdp_echo_preview_url = 0

                    -- a custom vim function name to open preview page
                    -- this function will receive url as param
                    -- default is empty
                    vim.g.mkdp_browserfunc = ''

                    -- options for markdown render
                    -- mkit: markdown-it options for render
                    -- katex: katex options for math
                    -- uml: markdown-it-plantuml options
                    -- maid: mermaid options
                    -- disable_sync_scroll: if disable sync scroll, default 0
                    -- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
                    --   middle: mean the cursor position alway show at the middle of the preview page
                    --   top: mean the vim top viewport alway show at the top of the preview page
                    --   relative: mean the cursor position alway show at the relative positon of the preview page
                    -- hide_yaml_meta: if hide yaml metadata, default is 1
                    -- sequence_diagrams: js-sequence-diagrams options
                    -- content_editable: if enable content editable for preview page, default: v:false
                    -- disable_filename: if disable filename header for preview page, default: 0
                    vim.g.mkdp_preview_options = {
                        ['mkit'] = {},
                        ['katex'] = {},
                        ['uml'] = {},
                        ['maid'] = {},
                        ['disable_sync_scroll'] = 0,
                        ['sync_scroll_type'] = 'middle',
                        ['hide_yaml_meta'] = 1,
                        ['sequence_diagrams'] = {},
                        ['flowchart_diagrams'] = {},
                        ['content_editable'] = 0,
                        ['disable_filename'] = 0
                    }

                    -- use a custom markdown style must be absolute path
                    -- like '/Users/username/markdown.css' or expand('~/markdown.css')
                    vim.g.mkdp_markdown_css = ''

                    -- use a custom highlight style must absolute path
                    -- like '/Users/username/highlight.css' or expand('~/highlight.css')
                    vim.g.mkdp_highlight_css = ''

                    -- use a custom port to start server or random for empty
                    vim.g.mkdp_port = ''

                    -- preview page title
                    -- ${name} will be replace with the file name
                    vim.g.mkdp_page_title = '「${name}」'

                    -- recognized filetypes
                    -- these filetypes will have MarkdownPreview... commands
                    vim.g.mkdp_filetypes = {'markdown', 'vimwiki'}
                end
            },

            -----------------
            -- Note Taking --
            -----------------

            {
                'oberblastmeister/neuron.nvim',
                disable = true,
                requires = {
                    'nvim-lua/plenary.nvim',
                    'nvim-lua/popup.nvim',
                    'nvim-telescope/telescope.nvim'
                },
            },

            {
                'vimwiki/vimwiki',
                disable = false,
                config = function ()
                    vim.g.vimwiki_list = {
                        {
                            ["path"] = "~/Downloads/github/cryptography.git/main/notes/",
                            ["syntax"] = "markdown",
                            ["ext"] = ".md"
                        },
                        {
                            ["path"] = "~/Downloads/github/reti_di_calcolatori/appunti/",
                            ["syntax"] = "markdown",
                            ["ext"] = ".md"
                        }
                    }

                    vim.g.vimwiki_markdown_link_ext = 1
                end
            },

            {
                'nvim-lua/plenary.nvim'
            },

            {
                'lewis6991/gitsigns.nvim',
                requires = {
                    'nvim-lua/plenary.nvim'
                },
                -- config = function()
                --     require("gitsigns").setup {
                --         signcolumn = true,
                --         current_line_blame = true,
                --         current_line_blame_opts = {
                --             virt_text = true,
                --             virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                --             delay = 500,
                --         }
                --     }
                -- end
            },

            -- Utils
            {
                'akinsho/toggleterm.nvim',
                setup = function ()
                    vim.o.hidden = false
                end,
                config = [[require'config.toggleterm']]
            },

            {
                'sychen52/smart-term-esc.nvim',
                config = function ()
                    require('smart-term-esc').setup{
                        key='<Esc>',
                        except={'nvim', 'fzf'}
                    }
                end
            }
        },

        config = {
            snapshot = nil,
            log = { log_level = log_level }
        }
    }

    for _, plugin in pairs(config[1]) do
        if not plugin.config and
            (not plugin.myopts or plugin.myopts and not plugin.myopts.ignore) then
            plugin.config = generate_config(plugin[1])
        end

    end

    return config
