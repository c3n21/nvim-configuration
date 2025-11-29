{ pkgs, ... }:
{
  # they contain a settings set defined above
  # see :help nixCats.flake.outputs.settings
  settings = {
    suffix-path = true;
    suffix-LD = true;
    wrapRc = true;
    # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    neovim-unwrapped = pkgs.neovim-unwrapped;
    autoconfigure = "suffix";
  };
  # and a set of categories that you want
  # (and other information to pass to lua)
  categories = {
    filemanager.oil = true;
    gitPlugins = {
      client.fugit2 = true;
      gutter.gitsigns = true;
      misc = true;
    };
  };
}
