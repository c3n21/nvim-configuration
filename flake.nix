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
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
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
        allowUnfree = true;
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
          # Add the easy-dotnet-server overlay
          (import ./overlays/easy-dotnet-server.nix)
          # add any other flake overlays here.

          # when other people mess up their overlays by wrapping them with system,
          # you may instead call this function on their overlay.
          # it will check if it has the system in the set, and if so return the desired overlay
          # (utils.fixSystemizedOverlay inputs.codeium.overlays
          #   (system: inputs.codeium.overlays.${system}.default)
          # )

          # This allows me in each packageDefinition to do `pkgs.neovim-unwrapped`
          # isolate every package definition.
          inputs.neovim-nightly-overlay.overlays.default
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
          vimPlugins = pkgs.vimPlugins;

          vscode-java-test = pkgs.vscode-extensions.vscjava.vscode-java-test;
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
            python = with pkgs; [
              ruff
              basedpyright
            ];

            java = with pkgs; [
              # Pinning this version as is the latest working with vscode-java-test 0.43.1
              (jdt-language-server.overrideAttrs {
                version = "1.51.0";
                src = pkgs.fetchurl {
                  url = "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.51.0/jdt-language-server-1.51.0-202510022025.tar.gz";
                  hash = "sha256-ilk3IReIG/W9wCIPIlRHKEa4gTfAWPNEsAp9QUJ3RaE=";

                };
              }

              )
              vscode-java-test
              javaPackages.compiler.openjdk21
              gradle
            ];

            xml = with pkgs; [
              xmlstarlet
            ];

            tailwindcss = with pkgs; [
              tailwindcss-language-server
            ];

            dotnet = with pkgs; [
              # TODO: to fix
              # easy-dotnet-server
              netcoredbg
              # custom-roslyn-command
              roslyn-ls
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

            yaml = with pkgs; [
              yaml-language-server
              yamlfmt
            ];

            clang = with pkgs; [
              clang-tools
            ];

            general = with pkgs; [
              inotify-tools
              typos-lsp
              # TODO: for sonarlint
              nodejs-slim_24
              # TODO: I want to put it under a subcategory
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

            haskell = with pkgs; [
              (haskell-language-server.override {
                supportedGhcVersions = [
                  "912"
                ];
              })

            ];

            nix = with pkgs; [
              nixd
              nixfmt
            ];

            node = with pkgs; [
              typescript-go
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
                    require('configs.go-nvim')
                  '';
              }

            ];

            dotnet = with pkgs.vimPlugins; [
              {
                plugin = roslyn-nvim.overrideAttrs (oldAttrs: {
                  src = pkgs.fetchFromGitHub {
                    owner = "seblyng";
                    repo = "roslyn.nvim";
                    rev = "4deb46ce892c279d3183661342c93aa2ec9716c6";
                    hash = "sha256-HyFCP8dyQ8Ak/kheO7uykuhxbI2tL2lAIb7aXVq+vJY=";
                  };
                });
              }

              {
                plugin = easy-dotnet-nvim.overrideAttrs (oldAttrs: {
                  src = pkgs.fetchFromGitHub {
                    owner = "GustavEikaas";
                    repo = "easy-dotnet.nvim";
                    rev = "84be98bcf7bf0c6b867524de3b250c7112fc74a4";
                    hash = "sha256-tBlydDRcE3flXud4kDP2N4/OzF67FRc00bN6l0CzMGk=";
                  };
                });

                config.lua = # lua
                  ''
                    require('configs.easy-dotnet')
                  '';
              }
            ];

            ai =
              with pkgs.vimPlugins;
              [
                {
                  plugin = copilot-lua;
                  config.lua = # lua
                    ''
                      require('configs.copilot')
                    '';
                }

                # Currently using Avante
                # {
                #   plugin = codecompanion-nvim;
                #   config.lua = # lua
                #     ''
                #       require('configs.code-companion')
                #     '';
                # }

                {
                  plugin = avante-nvim.overrideAttrs {

                    dependencies = with vimPlugins; [
                      img-clip-nvim
                      nui-nvim
                      nvim-treesitter
                      plenary-nvim
                    ];
                  };
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

            backend =

              # needed for rest.nvim
              (with pkgs.vimPlugins; [
                nvim-treesitter-parsers.http
              ])

              ++ [
                {
                  plugin = pkgs.vimPlugins.rest-nvim;
                  config.lua = # lua
                    ''
                      require('configs.rest-nvim')
                    '';
                }

              ]
              ++ [
                {
                  plugin = pkgs.vimPlugins.nvim-dbee;
                  config.lua = # lua
                    ''
                      require('configs.nvim-dbee')
                    '';
                }
              ];

            java = with pkgs.vimPlugins; [
              nvim-jdtls
            ];

            nlua = with pkgs.vimPlugins; [
              {
                plugin = lazydev-nvim;
                config.lua = # lua
                  ''
                    vim.lsp.config('lua_ls', {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'nixCats' },
                                },
                            },
                        },
                    })

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

                plugin = pkgs.vimPlugins.nvim-vtsls;

                config.lua = # lua
                  ''
                    vim.lsp.enable('vtsls')
                  '';
              }
              nvim-treesitter-parsers.jsdoc
              nvim-treesitter-parsers.tsx
              nvim-treesitter-parsers.typescript
            ];

            gitPlugins = {
              gutter = {
                gitsigns = [
                  {
                    plugin = vimPlugins.gitsigns-nvim;
                    config.lua = # lua
                      ''
                        require('configs.gitsigns')
                      '';
                  }
                ];
              };

              client = {
                neogit = [
                  {
                    plugin = pkgs.vimPlugins.neogit;
                    config.lua = # lua
                      ''
                        require('configs.neogit')
                      '';
                  }
                ];

                fugit2 = (
                  with vimPlugins;
                  [
                    {
                      plugin = fugit2-nvim.overrideAttrs {
                        runtimeDeps = [ pkgs.libgit2 ];
                        dependencies = [
                          nui-nvim
                          nvim-web-devicons
                          plenary-nvim
                        ];
                      };
                      config.lua = # lua
                        ''
                          require('configs.fugit2')
                        '';
                    }
                  ]
                );
              };

              misc = with vimPlugins; [
                vim-fugitive
                {
                  plugin = diffview-nvim;
                  config.lua = # lua
                    ''
                      require('configs.diffview')
                    '';
                }
              ];
            };

            fzf-lua = with pkgs.vimPlugins; [
              {
                plugin = fzf-lua;
                config.lua = # lua
                  ''
                    require('configs.fzf-lua')
                  '';
              }
            ];

            filemanager = {
              oil = [
                {
                  plugin = vimPlugins.oil-nvim;
                  config.lua = # lua
                    ''
                      require('configs.oil')
                    '';
                }
              ];
            };

            general = with pkgs.vimPlugins; [

              {
                plugin = nvim-treesitter-context;
                config.lua = # lua
                  ''
                    require('configs.nvim-treesitter-context')
                  '';
              }

              {
                plugin = otter-nvim;
                config.lua = # lua
                  ''
                    require('configs.otter')
                  '';

              }

              nvim-treesitter.withAllGrammars

              vim-sleuth

              {
                plugin = SchemaStore-nvim;
                config.lua = # lua
                  ''
                    vim.lsp.enable('jsonls')
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

              # {
              #   plugin = dropbar-nvim;
              #   config.lua = # lua
              #     ''
              #       -- require('configs.dropbar')
              #     '';
              # }

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
                plugin = pkgs.vimPlugins.sonarlint-nvim;
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

              nvim-treesitter-textobjects

              {
                plugin = nvim-ts-autotag;
                config.lua = # lua
                  ''
                    require('configs.nvim-ts-autotag')
                  '';
              }

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
            # backend = [
            #   (lp: [
            #     lp.rest-nvim
            #   ])
            # ];
          };

          optionalLuaAdditions = {

            haskell = [
              # lua
              ''
                vim.lsp.enable("hls")
              ''
            ];

            java = [
              # lua
              ''
                vim.lsp.config("jdtls", {
                  init_options = {
                    bundles = vim.fn.glob("${vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", true, true),
                  },
                  settings = {
                    java = {
                      configuration = {
                        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                        -- And search for `interface RuntimeOption`
                        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
                        runtimes = {
                          {
                            name = "JavaSE-17",
                            path = "${pkgs.openjdk17.outPath}/lib/openjdk",
                          },
                        }
                      },
                      import = {
                        gradle = {
                          enabled = false,
                          offline = {
                            enabled = true,
                          },
                          wrapper = {
                            enabled = false,  -- 🔴 this is the key
                          },
                        },
                      },
                    }
                  }
                })
                vim.lsp.enable("jdtls")
              ''

            ];

            dotnet = [
              # lua
              ''
                require('configs.nvim-dap.csharp')
                require('configs.roslyn-nvim')
                -- roslyn-nvim plugin handles lsp start
                -- vim.lsp.enable('roslyn_ls')
              ''
            ];

            solidity = [
              # lua
              ''
                vim.lsp.enable('solc')
              ''
            ];

            yaml = [
              # lua
              ''
                vim.lsp.enable('yamlls')
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

            nlua = [
              # lua
              ''
                vim.lsp.enable('lua_ls')
              ''
            ];

            python = [
              # lua
              ''
                vim.lsp.enable('basedpyright')
              ''
            ];

            node = [
              # lua
              # ''
              #   vim.lsp.enable('tsgo')
              # ''
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
        neo = import ./nix/nixCats/neo.nix;
        fugit2 = import ./nix/nixCats/fugit2.nix;
        neorg = import ./nix/nixCats/neorg.nix;
      };
      # In this section, the main thing you will need to do is change the default package name
      # to the name of the packageDefinitions entry you wish to use as the default.
      defaultPackageName = "neo";
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
            shellHook = "";
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
