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
              fswatch
              typos-lsp
              #TODO: I want to put it under a subcategory
              sonarlint-ls
              # for jsonls
              vscode-langservers-extracted
              yaml-language-server
            ];

            go = with pkgs; [
              gopls
            ];

            nix = with pkgs; [
              nixd
              nixfmt-rfc-style
            ];

            node = with pkgs; [
              prettierd
              # for eslint-lsp
              vscode-langservers-extracted
            ];

            nlua = with pkgs; [
              lua-language-server
              stylua
              selene
            ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = {

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
                config.lua = builtins.readFile ./nixCats/nvim-dbee.lua;
              }
            ];

            nlua = with pkgs.vimPlugins; [
              {
                plugin = lazydev-nvim;
                config.lua = builtins.readFile ./nixCats/lazydev.lua;
              }
              nvim-treesitter-parsers.lua
            ];

            note =
              with pkgs.vimPlugins;
              [

                {
                  plugin = neorg;
                  config.lua = builtins.readFile ./nixCats/neorg.lua;
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
                  config.lua = builtins.readFile ./nixCats/gitsigns.lua;
                }

                {
                  plugin = neogit;
                  config.lua = builtins.readFile ./nixCats/neogit.lua;
                }

                vim-fugitive
                diffview-nvim
              ]);

            fzf-lua = with pkgs.vimPlugins; [
              {
                plugin = fzf-lua;
                config.lua = builtins.readFile ./nixCats/fzf-lua.lua;
              }
            ];

            general = with pkgs.vimPlugins; [

              {
                plugin = otter-nvim;
                config.lua = builtins.readFile ./nixCats/nvim-lspconfig.lua;

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
                config.lua = builtins.readFile ./nixCats/copilot.lua;
              }

              {
                plugin = vim-matchup;
                config.lua = builtins.readFile ./nixCats/vim-matchup.lua;
              }

              {
                plugin = vim-illuminate;
                config.lua = builtins.readFile ./nixCats/vim-illuminate.lua;
              }

              {
                plugin = oil-nvim;
                config.lua = builtins.readFile ./nixCats/oil.lua;
              }

              {
                plugin = dropbar-nvim;
                # config.lua = builtins.readFile ./nixCats;
              }

              {
                plugin = lualine-nvim;
                config.lua = builtins.readFile ./nixCats/lualine.lua;
              }

              {
                plugin = indent-blankline-nvim;
                config.lua = builtins.readFile ./nixCats/indent-blankline.lua;
              }
              {
                plugin = pluginsPkgs.vimPlugins.sonarlint-nvim;
                config.lua = builtins.readFile ./nixCats/sonarlint-nvim.lua;
              }

              {
                plugin = auto-session;
                config.lua = builtins.readFile ./nixCats/auto-session.lua;
              }

              {
                plugin = nvim-colorizer-lua;
                config.lua = builtins.readFile ./nixCats/colorizer.lua;

              }

              blink-copilot

              {
                plugin = blink-cmp;
                config.lua = builtins.readFile ./nixCats/blink.lua;
              }

              {
                plugin = nvim-lspconfig;
                config.lua = builtins.readFile ./nixCats/nvim-lspconfig.lua;
              }

              {
                plugin = nvim-surround;
                config.lua = builtins.readFile ./nixCats/nvim-surround.lua;
              }

              {
                plugin = nvim-treesitter;
                config.lua = builtins.readFile ./nixCats/nvim-treesitter.lua;
              }
              nvim-treesitter-textobjects

              {
                plugin = nvim-ts-autotag;
                config.lua = builtins.readFile ./nixCats/nvim-ts-autotag.lua;
              }

              nvim-ts-context-commentstring

              {
                plugin = nvim-web-devicons;
                config.lua = builtins.readFile ./nixCats/nvim-web-devicons.lua;
              }

              {
                plugin = nvim-autopairs;
                config.lua = builtins.readFile ./nixCats/nvim-autopairs.lua;
              }

              {
                plugin = comment-nvim;
                config.lua = builtins.readFile ./nixCats/comment.lua;
              }

              {
                plugin = conform-nvim;
                config.lua = builtins.readFile ./nixCats/conform.lua;
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
            astro = [
              # lua
              ''
                vim.lsp.enable('astro')
              ''
            ];

            go = [
              # lua
              ''
                vim.lsp.enable('gopls')
              ''
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
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
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
