# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license

# This is an empty nixCats config.
# you may import this template directly into your nvim folder
# and then add plugins to categories here,
# and call the plugins with their default functions
# within your lua, rather than through the nvim package manager's method.
# Use the help, and the example config github:BirdeeHub/nixCats-nvim?dir=templates/example

# It allows for easy adoption of nix,
# while still providing all the extra nix features immediately.
# Configure in lua, check for a few categories, set a few settings,
# output packages with combinations of those categories and settings.

# All the same options you make here will be automatically exported in a form available
# in home manager and in nixosModules, as well as from other flakes.
# each section is tagged with its relevant help section.

{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-nixpkgs.url = "github:nixos/nixpkgs/master";
    plugins-neorg-interim-ls.url = "github:benlubas/neorg-interim-ls";
    plugins-jq-playground-nvim = {
      url = "github:yochem/jq-playground.nvim";
      flake = false;
    };

    plugins-mcphub-nvim = {
      url = "github:ravitemer/mcphub.nvim";
      flake = false;
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    # see :help nixCats.flake.inputs
    # If you want your plugin to be loaded by the standard overlay,
    # i.e. if it wasnt on nixpkgs, but doesnt have an extra build step.
    # Then you should name it "plugins-something"
    # If you wish to define a custom build step not handled by nixpkgs,
    # then you should name it in a different format, and deal with that in the
    # overlay defined for custom builds in the overlays directory.
    # for specific tags, branches and commits, see:
    # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html#examples

  };

  # see :help nixCats.flake.outputs
  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      # the following extra_pkg_config contains any values
      # which you want to pass to the config set of nixpkgs
      # import nixpkgs { config = extra_pkg_config; inherit system; }
      # will not apply to module imports
      # as that will have your system values
      extra_pkg_config = {
        # allowUnfree = true;
      };
      # management of the system variable is one of the harder parts of using flakes.

      # so I have done it here in an interesting way to keep it out of the way.
      # It gets resolved within the builder itself, and then passed to your
      # categoryDefinitions and packageDefinitions.

      # this allows you to use ${pkgs.system} whenever you want in those sections
      # without fear.

      # see :help nixCats.flake.outputs.overlays
      dependencyOverlays = # (import ./overlays inputs) ++
        [
          # This overlay grabs all the inputs named in the format
          # `plugins-<pluginName>`
          # Once we add this overlay to our nixpkgs, we are able to
          # use `pkgs.neovimPlugins`, which is a set of our plugins.
          (utils.standardPluginOverlay inputs)
          # add any other flake overlays here.

          # when other people mess up their overlays by wrapping them with system,
          # you may instead call this function on their overlay.
          # it will check if it has the system in the set, and if so return the desired overlay
          # (utils.fixSystemizedOverlay inputs.codeium.overlays
          #   (system: inputs.codeium.overlays.${system}.default)
          # )
        ];

      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          mkPlugin,
          ...
        }@packageDef:
        let
          pluginsPkgs = inputs.plugins-nixpkgs.legacyPackages.${pkgs.system};
          sonarlint-ls = (
            pkgs.sonarlint-ls.overrideAttrs (oldAttrs: {
              installPhase = ''
                ${oldAttrs.installPhase}

                makeWrapper ${oldAttrs.mvnJdk.outPath}/bin/java $out/bin/sonarlint-ls \
                  --add-flags "-jar $out/share/sonarlint-ls.jar"
              '';
            })
          );
        in
        {
          # to define and use a new category, simply add a new list to a set here,
          # and later, you will include categoryname = true; in the set you
          # provide when you build the package using this builder function.
          # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

          # lspsAndRuntimeDeps:
          # this section is for dependencies that should be available
          # at RUN TIME for plugins. Will be available to PATH within neovim terminal
          # this includes LSPs
          lspsAndRuntimeDeps = {
            tailwindcss = with pkgs; [
              tailwindcss-language-server
            ];

            solidity = with pkgs; [
              solc
            ];

            astro = with pkgs; [
              astro-language-server
            ];

            json = with pkgs; [
              # TODO put it as runtimeDep for jq-playground
              jq
            ];

            clang = with pkgs; [
              clang-tools
            ];

            general = with pkgs; [
              inotify-tools
              typos-lsp
              #TODO: I want to put it under a subcategory
              sonarlint-ls
              # for jsonls
              vscode-langservers-extracted
              yaml-language-server
            ];

            go = with pkgs; [
              gopls
              go
              delve
            ];

            nix = with pkgs; [
              nixd
              nixfmt-rfc-style
            ];

            node = with pkgs; [
              prettierd
              # for eslint-lsp
              vscode-langservers-extracted
              vscode-js-debug
            ];

            nlua = with pkgs; [
              lua-language-server
              stylua
              selene
            ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = {

            # TODO: lazy load
            dap = with pkgs.vimPlugins; [
              {
                plugin = nvim-dap;
                config.lua = # lua
                  ''
                    require('configs.nvim-dap')
                  '';
              }

            ];

            go = with pkgs.vimPlugins; [
              {
                plugin = nvim-dap-go;
                config.lua = # lua
                  ''
                    require('configs/nvim-dap/go')
                  '';
              }
              {
                plugin = go-nvim;
                config.lua = # lua
                  ''
                    require('go').setup({
                      disable_defaults = true, -- true|false when true set false to all boolean settings and replace all tables
                      preludes = { -- experimental feature, set to empty to disable; set to function to enable
                        default = function()
                          return {}
                        end, -- one for all commands
                        GoRun = function() -- the commands to run before GoRun, this override default
                          return {} -- e.g. return {'watchexe', '--restart', '-v', '-e', 'go'}
                          -- so you will run `watchexe --restart -v -e go go run `
                        end,
                      },
                      -- remap_commands = {}, -- Vim commands to remap or disable, e.g. `{ GoFmt = "GoFormat", GoDoc = false }`
                      -- settings with {}; string will be set to "". user need to setup ALL the settings
                      -- It is import to set ALL values in your own config if set value to true otherwise the plugin may not work
                      go='go', -- go command, can be go[default] or e.g. go1.18beta1
                      goimports ='gopls', -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
                      gofmt = 'gopls', -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
                      fillstruct = 'gopls',  -- set to fillstruct if gopls fails to fill struct
                      max_line_len = 0, -- max line length in golines format, Target maximum line length for golines
                      tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
                      tag_options = 'json=omitempty', -- sets options sent to gomodifytags, i.e., json=omitempty
                      gotests_template = "", -- sets gotests -template parameter (check gotests for details)
                      gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
                      gotest_case_exact_match = true, -- true: run test with ^Testname$, false: run test with TestName
                      comment_placeholder = "" ,  -- comment_placeholder your cool placeholder e.g. 󰟓       
                      icons = {breakpoint = '🧘', currentpos = '🏃'},  -- setup to `false` to disable icons setup
                      verbose = false,  -- output loginf in messages
                      lsp_semantic_highlights = false, -- use highlights from gopls, disable by default as gopls/nvim not compatible
                      lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
                                       -- false: do nothing
                                       -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
                                       -- lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
                      lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
                                          -- false: do not set default gofmt in gopls format to gofumpt
                      lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
                                           --      when lsp_cfg is true
                                           -- if lsp_on_attach is a function: use this function as on_attach function for gopls
                      lsp_keymaps = false,  -- set to false to disable gopls/lsp keymap
                      lsp_codelens = false,  -- set to false to disable codelens, true by default, you can use a function
                                            -- function(bufnr)
                                            --    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap=true, silent=true})
                                            -- end
                                            -- to setup a table of codelens
                      golangci_lint = {
                        default = 'standard', -- set to one of { 'standard', 'fast', 'all', 'none' }
                        -- disable = {'errcheck', 'staticcheck'}, -- linters to disable empty by default
                        -- enable = {'govet', 'ineffassign','revive', 'gosimple'}, -- linters to enable; empty by default
                        config = nil,        -- set to a config file path
                        no_config = false,   -- true: golangci-lint --no-config
                        -- disable = {},     -- linters to disable empty by default, e.g. {'errcheck', 'staticcheck'}
                        -- enable = {},      -- linters to enable; empty by default, set to e.g. {'govet', 'ineffassign','revive', 'gosimple'}
                        -- enable_only = {}, -- linters to enable only; empty by default, set to e.g. {'govet', 'ineffassign','revive', 'gosimple'}
                        severity = vim.diagnostic.severity.INFO, -- severity level of the diagnostics
                      },
                      -- null_ls = {    -- check null-ls integration in readme
                      --   golangci_lint = {
                      --     method = {"NULL_LS_DIAGNOSTICS_ON_SAVE", "NULL_LS_DIAGNOSTICS_ON_OPEN"}, -- when it should run
                      --     severity = vim.diagnostic.severity.INFO, -- severity level of the diagnostics
                      --   },
                      --   gotest = {
                      --     method = {"NULL_LS_DIAGNOSTICS_ON_SAVE"}, -- when it should run
                      --     severity = vim.diagnostic.severity.WARN, -- severity level of the diagnostics
                      --   },
                      -- },
                      diagnostic = false,
                      -- diagnostic = {  -- set diagnostic to false to disable vim.diagnostic.config setup,
                      --                 -- true: default nvim setup
                      --   hdlr = false, -- hook lsp diag handler and send diag to quickfix
                      --   underline = true,
                      --   virtual_text = { spacing = 2, prefix = '' }, -- virtual text setup
                      --   signs = {'', '', '', ''},  -- set to true to use default signs, an array of 4 to specify custom signs
                      --   update_in_insert = false,
                      -- },
                      -- if you need to setup your ui for input and select, you can do it here
                      -- go_input = require('guihua.input').input -- set to vim.ui.input to disable guihua input
                      -- go_select = require('guihua.select').select -- vim.ui.select to disable guihua select
                      -- lsp_document_formatting = true,
                      -- set to true: use gopls to format
                      -- false if you want to use other formatter tool(e.g. efm, nulls)
                      lsp_inlay_hints = {
                        enable = false, -- this is the only field apply to neovim > 0.10
                      },
                      -- gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
                      -- gopls_remote_auto = true, -- add -remote=auto to gopls
                      gocoverage_sign = "█",
                      sign_priority = 5, -- change to a higher number to override other signs
                      dap_debug = true, -- set to false to disable dap
                      dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
                                               -- false: do not use keymap in go/dap.lua.  you must define your own.
                                               -- Windows: Use Visual Studio keymap
                      dap_debug_gui = {}, -- bool|table put your dap-ui setup here set to false to disable
                      dap_debug_vt = { enabled = true, enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable

                      dap_port = 38697, -- can be set to a number, if set to -1 go.nvim will pick up a random port
                      dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
                      dap_retries = 20, -- see dap option max_retries
                      dap_enrich_config = nil, -- see dap option enrich_config
                      build_tags = "tag1,tag2", -- set default build tags
                      textobjects = true, -- enable default text objects through treesittter-text-objects
                      test_runner = 'go', -- one of {`go`,  `dlv`, `ginkgo`, `gotestsum`}
                      verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
                      run_in_floaterm = false, -- set to true to run in a float window. :GoTermClose closes the floatterm
                                               -- float term recommend if you use gotestsum ginkgo with terminal color

                      floaterm = {   -- position
                        posititon = 'auto', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
                        width = 0.45, -- width of float window if not auto
                        height = 0.98, -- height of float window if not auto
                        title_colors = 'nord', -- default to nord, one of {'nord', 'tokyo', 'dracula', 'rainbow', 'solarized ', 'monokai'}
                                                  -- can also set to a list of colors to define colors to choose from
                                                  -- e.g {'#D8DEE9', '#5E81AC', '#88C0D0', '#EBCB8B', '#A3BE8C', '#B48EAD'}
                      },
                      trouble = false, -- true: use trouble to open quickfix
                      test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
                      luasnip = false, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
                      --  Do not enable this if you already added the path, that will duplicate the entries
                      on_jobstart = function(cmd) _=cmd end, -- callback for stdout
                      on_stdout = function(err, data) _, _ = err, data end, -- callback when job started
                      on_stderr = function(err, data)  _, _ = err, data  end, -- callback for stderr
                      on_exit = function(code, signal, output)  _, _, _ = code, signal, output  end, -- callback for jobexit, output : string
                      iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the beginning of if err statement
                      iferr_less_highlight = false, -- set to true to make 'if err != nil' statements less highlighted (grayed out)
                    })

                    vim.lsp.enable('gopls')
                  '';
              }

            ];

            ai =
              with pkgs.vimPlugins;
              [
                {
                  plugin = codecompanion-nvim;
                  config.lua = # lua
                    ''
                      require('configs.code-companion')
                    '';
                }
                {
                  plugin = avante-nvim;
                  config.lua = # lua
                    ''
                      require('configs.avante')
                    '';
                }

                {

                  plugin = blink-cmp-avante;
                }
              ]
              ++ (with pkgs.neovimPlugins; [
                mcphub-nvim
              ]);

            # TODO: lazy load maybe?
            json = with pkgs.neovimPlugins; [
              jq-playground-nvim
            ];

            backend = with pkgs.vimPlugins; [
              {
                plugin = (
                  pluginsPkgs.vimPlugins.nvim-dbee.overrideAttrs {
                    src = pkgs.fetchFromGitHub {
                      owner = "c3n21";
                      repo = "nvim-dbee";
                      rev = "1420cfc85ee1b8c73664249a741692d851bffe7f";
                      hash = "sha256-Vbw/+YJq0l/0tHWCN6K2V9J0byh7jGvScPdSPDDE7O0=";
                    };
                  }
                );
                config.lua = # lua
                  ''
                    require('configs.nvim-dbee')
                  '';
              }
            ];

            nlua = with pkgs.vimPlugins; [
              {
                plugin = lazydev-nvim;
                config.lua = # lua
                  ''
                    require('configs.lazydev')
                  '';
              }
              nvim-treesitter-parsers.lua
            ];

            solidity = with pkgs.vimPlugins; [
              solidity
            ];

            note =
              with pkgs.vimPlugins;
              [

                {
                  plugin = neorg;
                  config.lua = # lua
                    ''
                      require('configs.neorg')
                    '';
                }
              ]
              ++ (with pkgs.neovimPlugins; [
                neorg-interim-ls
              ]);

            astro = with pkgs.vimPlugins; [
              nvim-treesitter-parsers.astro
            ];

            node = with pkgs.vimPlugins; [
              {

                plugin = pluginsPkgs.vimPlugins.nvim-vtsls;

                config.lua = # lua
                  ''
                    vim.lsp.enable('vtsls')
                  '';
              }
              nvim-treesitter-parsers.jsdoc
              nvim-treesitter-parsers.tsx
              nvim-treesitter-parsers.typescript
            ];

            gitPlugins =
              with pkgs.neovimPlugins;
              [
              ]
              ++ (with pkgs.vimPlugins; [
                {
                  plugin = gitsigns-nvim;
                  config.lua = # lua
                    ''
                      require('configs.gitsigns')
                    '';
                }

                {
                  plugin = neogit;
                  config.lua = # lua
                    ''
                      require('configs.neogit')
                    '';
                }

                vim-fugitive
                diffview-nvim
              ]);

            fzf-lua = with pkgs.vimPlugins; [
              {
                plugin = fzf-lua;
                config.lua = # lua
                  ''
                    require('configs.fzf-lua')
                  '';
              }
            ];

            general = with pkgs.vimPlugins; [

              {
                plugin = otter-nvim;
                config.lua = # lua
                  ''
                    require('configs.otter')
                  '';

              }

              nvim-treesitter.withAllGrammars

              sleuth

              {
                plugin = SchemaStore-nvim;
                config.lua = # lua
                  ''
                    vim.lsp.enable('jsonls')
                  '';
              }

              {
                plugin = copilot-lua;
                config.lua = # lua
                  ''
                    require('configs.copilot')
                  '';
              }

              {
                plugin = vim-matchup;
                config.lua = # lua
                  ''
                    require('configs.vim-matchup')
                  '';
              }

              {
                plugin = vim-illuminate;
                config.lua = # lua
                  ''
                    require('configs.vim-illuminate')
                  '';
              }

              {
                plugin = oil-nvim;
                config.lua = # lua
                  ''
                    require('configs.oil')
                  '';
              }

              {
                plugin = dropbar-nvim;
                # config.lua = builtins.readFile ./nixCats;
              }

              {
                plugin = lualine-nvim;
                config.lua = # lua
                  ''
                    require('configs.lualine')
                  '';
              }

              {
                plugin = indent-blankline-nvim;
                config.lua = # lua
                  ''
                    require('configs.indent-blankline')
                  '';
              }
              {
                plugin = pluginsPkgs.vimPlugins.sonarlint-nvim;
                config.lua = # lua
                  ''
                    require('configs.sonarlint-nvim')
                  '';
              }

              {
                plugin = auto-session;
                config.lua = # lua
                  ''
                    require('configs.auto-session')
                  '';
              }

              {
                plugin = nvim-colorizer-lua;
                config.lua = # lua
                  ''
                    require('configs.colorizer')
                  '';

              }

              blink-copilot

              {
                plugin = blink-cmp;
                config.lua = # lua
                  ''
                    require('configs.blink')
                  '';
              }

              {
                plugin = nvim-lspconfig;
                config.lua = # lua
                  ''
                    require('configs.nvim-lspconfig')
                  '';
              }

              {
                plugin = nvim-surround;
                config.lua = # lua
                  ''
                    require('configs.nvim-surround')
                  '';
              }

              {
                plugin = nvim-treesitter;
                config.lua = # lua
                  ''
                    require('configs.nvim-treesitter')
                  '';
              }
              nvim-treesitter-textobjects

              {
                plugin = nvim-ts-autotag;
                config.lua = # lua
                  ''
                    require('configs.nvim-ts-autotag')
                  '';
              }

              nvim-ts-context-commentstring

              {
                plugin = nvim-web-devicons;
                config.lua = # lua
                  ''
                    require('configs.nvim-web-devicons')
                  '';
              }

              {
                plugin = nvim-autopairs;
                config.lua = # lua
                  ''
                    require('configs.nvim-autopairs')
                  '';
              }

              {
                plugin = comment-nvim;
                config.lua = # lua
                  ''
                    require('configs.comment')
                  '';
              }

              {
                plugin = conform-nvim;
                config.lua = # lua
                  ''
                    require('configs.conform')
                  '';
              }

              # nvim-treesitter-parsers.commonlisp
              # nvim-treesitter-parsers.javascript
              # nvim-treesitter-parsers.java
              # nvim-treesitter-parsers.astro
              # nvim-treesitter-parsers.nix
              # nvim-treesitter-parsers.terraform
              # nvim-treesitter-parsers.yaml
              # nvim-treesitter-parsers.bash
              # nvim-treesitter-parsers.ssh_config
              # nvim-treesitter-parsers.go
              # nvim-treesitter-parsers.angular
              # nvim-treesitter-parsers.luadoc
              # nvim-treesitter-parsers.norg

            ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          optionalPlugins = {
            gitPlugins = with pkgs.neovimPlugins; [ ];
            general = with pkgs.vimPlugins; [ ];
          };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            general = with pkgs; [
              # libgit2
            ];
          };

          # environmentVariables:
          # this section is for environmentVariables that should be available
          # at RUN TIME for plugins. Will be available to path within neovim terminal
          environmentVariables = {
            test = {
              CATTESTVAR = "It worked!";
            };
          };

          # If you know what these are, you can provide custom ones by category here.
          # If you dont, check this link out:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
          extraWrapperArgs = {
            test = [
              ''--set CATTESTVAR2 "It worked again!"''
            ];
          };

          # lists of the functions you would have passed to
          # python.withPackages or lua.withPackages
          # do not forget to set `hosts.python3.enable` in package settings

          # get the path to this python environment
          # in your lua config via
          # vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          python3.libraries = {
            test = (_: [ ]);
          };
          # populates $LUA_PATH and $LUA_CPATH
          extraLuaPackages = {
            test = [ (_: [ ]) ];
          };

          optionalLuaAdditions = {

            solidity = [
              # lua
              ''
                vim.lsp.enable('solc')
              ''
            ];

            tailwindcss = [
              # lua
              ''
                vim.lsp.enable('tailwindcss')
              ''
            ];
            astro = [
              # lua
              ''
                vim.lsp.enable('astro')
              ''
            ];

            general = [
              # lua
              ''
                vim.lsp.enable('typos_lsp')
              ''
            ];

            go = [
              # lua
              # ''
              #   vim.lsp.enable('gopls')
              # ''
            ];

            clang = [
              # lua
              ''
                vim.lsp.enable('clangd')
              ''

            ];

            node = [
              # lua
              ''
                require('configs.nvim-dap.js')
                vim.lsp.enable('eslint')
              ''

            ];

            nix = [
              # lua
              ''
                vim.lsp.enable('nixd')
              ''
            ];
          };

        };

      # And then build a package with specific categories from above here:
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # These are the names of your packages
        # you can include as many as you wish.
        vi =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              nlua = true;
              nix = true;
              general = true;
              fzf-lua = true;
              gitPlugins = true;
              json = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        ngo =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              ai = true;
              general = true;
              fzf-lua = true;
              gitPlugins = true;
              backend = true;
              go = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        nhh =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              general = true;
              solidity = true;
              fzf-lua = true;
              gitPlugins = true;
              node = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        nsol =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              general = true;
              solidity = true;
              fzf-lua = true;
              gitPlugins = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        nno =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              general = true;
              node = true;
              fzf-lua = true;
              gitPlugins = true;
              json = true;
              tailwindcss = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        nastro =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
              autoconfigure = "suffix";
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              ai = true;
              tailwindcss = true;
              astro = true;
              general = true;
              node = true;
              fzf-lua = true;
              gitPlugins = true;
              json = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        neo =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = false;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
              autoconfigure = "suffix";
              hosts = {
                neovide = {
                  # Will create a `packagename-neovide` in your path that launches the
                  # package named `packagename` in this case.
                  enable = true;
                  path = {
                    value = "${pkgs.neovide}/bin/neovide";
                    args = [
                      "--add-flags"
                      "--neovim-bin ${name}"
                    ];
                  };
                };
              };

            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              ai = true;
              astro = true;
              backend = true;
              clang = true;
              fzf-lua = true;
              general = true;
              gitPlugins = true;
              go = true;
              dap = true;
              json = true;
              nix = true;
              nlua = true;
              node = true;
              note = true;
              tailwindcss = true;
            };
          };

        nclang =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              general = true;
              note = true;
              fzf-lua = true;
              gitPlugins = true;
              clang = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };

        note =
          { pkgs, name, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              general = true;
              note = true;
              fzf-lua = true;
              gitPlugins = true;
              # customPlugins = true;
              # test = true;
              # example = {
              #   youCan = "add more than just booleans";
              #   toThisSet = [
              #     "and the contents of this categories set"
              #     "will be accessible to your lua with"
              #     "nixCats('path.to.value')"
              #     "see :help nixCats"
              #   ];
              # };
            };
          };
      };
      # In this section, the main thing you will need to do is change the default package name
      # to the name of the packageDefinitions entry you wish to use as the default.
      defaultPackageName = "vi";
    in

    # see :help nixCats.flake.outputs.exports
    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        # this is just for using utils such as pkgs.mkShell
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # these outputs will be wrapped with ${system} by utils.eachSystem

        # this will make a package out of each of the packageDefinitions defined above
        # and set the default package to the one passed in here.
        packages = (utils.mkAllWithDefault defaultPackage) // {
          neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${system}.neovim;
        };

        # choose your package for devShell
        # and add whatever else you want in it.
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = '''';
          };
        };

      }
    )
    // (
      let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
        # and the same for home manager
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {

        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );

}
